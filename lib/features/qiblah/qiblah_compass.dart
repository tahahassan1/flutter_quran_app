import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:flutter_quran_app/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

import '../../core/helpers/alert_helper.dart';
import '../../core/theme/app_assets.dart';
import '../../core/theme/app_styles.dart';
import 'custom_compass.dart';

class QiblahCompass extends StatefulWidget {
  const QiblahCompass({super.key});

  @override
  State<QiblahCompass> createState() => _QiblahCompassState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahCompassState extends State<QiblahCompass>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool hasPermission = false;
  bool serviceEnabled = true;
  bool permissionPermanentlyDenied = false;
  bool _wasAligned = false;
  static const double _alignmentThreshold = 10.0;

  Future<void> _refreshStatus() async {
    final service = await Permission.location.serviceStatus.isEnabled;
    final status = await Permission.location.status;
    setState(() {
      serviceEnabled = service;
      hasPermission = status.isGranted;
      permissionPermanentlyDenied = status.isPermanentlyDenied;
    });
  }

  Future<void> _requestPermission() async {
    final result = await Permission.location.request();
    await _refreshStatus();
    if (mounted) {
      if (result.isGranted) {
        AlertHelper.showSuccessAlert(context, message: 'تم منح صلاحية الموقع.');
      } else if (result.isPermanentlyDenied) {
        AlertHelper.showWarningAlert(
          context,
          message: 'الرجاء تفعيل صلاحية الموقع من الإعدادات.',
        );
      } else {
        AlertHelper.showWarningAlert(
          context,
          message: 'تم رفض صلاحية الموقع. لن تعمل ميزة تحديد القبلة.',
        );
      }
    }
  }

  Future<void> _openLocationSettings() async {
    final opened = await Geolocator.openLocationSettings();
    if (!opened) return;
    await _refreshStatus();
  }

  Future<void> _openAppSettings() async {
    final opened = await openAppSettings();
    if (!opened) return;
    await _refreshStatus();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _refreshStatus();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshStatus();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (!serviceEnabled) {
          return _PermissionPanel(
            icon: Icons.location_disabled,
            title: 'خدمة الموقع متوقفة',
            message: 'فعّل خدمة الموقع لتحديد اتجاه القبلة بدقة.',
            primaryLabel: 'فتح إعدادات الموقع',
            onPrimaryPressed: _openLocationSettings,
            secondaryLabel: 'تحديث الحالة',
            onSecondaryPressed: _refreshStatus,
          );
        }

        if (!hasPermission && permissionPermanentlyDenied) {
          return _PermissionPanel(
            icon: Icons.lock,
            title: 'الصلاحية مرفوضة دائمًا',
            message:
                'لا يمكن للتطبيق العمل دون صلاحية الموقع. افتح الإعدادات ومنح الإذن.',
            primaryLabel: 'فتح إعدادات التطبيق',
            onPrimaryPressed: _openAppSettings,
            secondaryLabel: 'تحديث الحالة',
            onSecondaryPressed: _refreshStatus,
          );
        }

        if (!hasPermission) {
          return _PermissionPanel(
            icon: Icons.location_on,
            title: 'مطلوب صلاحية الموقع',
            message:
                'نستخدم موقعك لحساب اتجاه القبلة. الرجاء منح الإذن للمتابعة.',
            primaryLabel: 'منح الإذن',
            onPrimaryPressed: _requestPermission,
            secondaryLabel: 'تحديث الحالة',
            onSecondaryPressed: _refreshStatus,
          );
        }

        return StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(AppAssets.lottiesCircularIndicator),
              );
            }

            if (snapshot.hasError || snapshot.data == null) {
              return _PermissionPanel(
                icon: Icons.explore_off,
                title: 'تعذر تحديد الاتجاه',
                message: 'حاول مرة أخرى أو تأكد من تفعيل المستشعرات.',
                primaryLabel: 'تحديث',
                onPrimaryPressed: _refreshStatus,
              );
            }

            final qiblahDirection = snapshot.data;
            final qiblahAngle = qiblahDirection!.qiblah;

            // Check if aligned with qiblah (angle close to 0 or 360, but NOT 180)
            // Normalize angle to 0-180 range to find the shortest distance to 0°
            double normalizedAngle = qiblahAngle.abs() % 360;
            if (normalizedAngle > 180) {
              normalizedAngle = 360 - normalizedAngle;
            }
            // Only align if angle is close to 0° (not close to 180°)
            final isAligned = normalizedAngle <= _alignmentThreshold;

            // Vibrate when entering the aligned zone (use post-frame callback to avoid build issues)
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (isAligned && !_wasAligned) {
                if (await Vibration.hasVibrator()) {
                  Vibration.vibrate();
                }
                if (mounted) {
                  setState(() {
                    _wasAligned = true;
                  });
                }
              } else if (!isAligned && _wasAligned) {
                if (mounted) {
                  setState(() {
                    _wasAligned = false;
                  });
                }
              }
            });

            animation = Tween(begin: begin, end: -qiblahAngle)
                .animate(_animationController!);
            begin = -qiblahAngle;
            _animationController!.forward(from: 0);

            return SizedBox(
              height: 300.h,
              width: context.screenWidth,
              child: Stack(
                children: [
                  Positioned.fill(
                    bottom: 240.h,
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.expand_less_rounded,
                        color: isAligned ? Colors.red : AppColors.red,
                        size: 50,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CustomPaint(
                      size: MediaQuery.of(context).size,
                      painter: CompassCustomPainter(angle: animation!.value),
                      child: Image.asset(
                        AppAssets.imagesKaaba,
                        width: context.screenWidth * .25,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _PermissionPanel extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;

  const _PermissionPanel({
    required this.icon,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: AppColors.green),
            SizedBox(height: 16.h),
            Text(title,
                style: AppStyles.style22u.copyWith(
                  color: context.primaryColor,
                ),
                textAlign: TextAlign.center),
            SizedBox(height: 8.h),
            Text(
              message,
              style: AppStyles.style16.copyWith(
                color: context.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                ),
                onPressed: onPrimaryPressed,
                child: Text(
                  primaryLabel,
                  style: AppStyles.style16.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (secondaryLabel != null && onSecondaryPressed != null) ...[
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onSecondaryPressed,
                  child: Text(
                    secondaryLabel!,
                    style: AppStyles.style16.copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
