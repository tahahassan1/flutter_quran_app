import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/extensions/widgets_ext.dart';
import 'package:flutter_quran_app/core/widgets/top_bar_widget.dart';
import 'package:flutter_quran_app/features/qiblah/qiblah_compass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_assets.dart';

class QiblahScreen extends StatelessWidget {
  const QiblahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.imagesWhiteBackground,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: TopBar(
                height: context.isLandscape ? 350.h : 280.h, label: 'القبلة'),
          ),
          Positioned.fill(top: 280.h, child: const QiblahCompass()),
        ],
      ).withSafeArea(),
    );
  }
}
