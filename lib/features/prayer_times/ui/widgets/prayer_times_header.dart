import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_assets.dart';
import '../../../../core/widgets/top_bar_widget.dart';

class PrayerTimesHeader extends StatefulWidget {
  const PrayerTimesHeader({super.key, required this.isMorning});
  final bool isMorning;

  @override
  State<PrayerTimesHeader> createState() => _PrayerTimesHeaderState();
}

class _PrayerTimesHeaderState extends State<PrayerTimesHeader> {
  @override
  void initState() {
    if (widget.isMorning) {
      changeBrightness(Brightness.dark);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.isMorning) {
      changeBrightness(Brightness.light);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Stack(
        children: [
          TopBar(
            image: widget.isMorning
                ? AppAssets.imagesMorningBackground
                : AppAssets.imagesEveningBackground,
            height: 190.h + context.topPadding,
          ),
          Positioned(
            right: 20.w,
            top: 20.h + context.topPadding,
            child: SvgPicture.asset(
              AppAssets.svgsPrayersTitle,
              width: context.screenWidth * .4,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
