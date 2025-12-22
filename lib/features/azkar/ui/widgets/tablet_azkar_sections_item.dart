import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_quran_app/features/azkar/ui/azkar_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/helpers/extensions/screen_details.dart';
import '../../../azkar/ui/azkar_sections_screen.dart';

class TabletAzkarSectionsItem extends StatelessWidget {
  const TabletAzkarSectionsItem({super.key, required this.section});
  final AzkarSection section;

  @override
  Widget build(BuildContext context) {
    if (context.isLandscape) {
      return LandscapeTabletAzkarSectionsItem(section: section);
    }
    return ZoomTapAnimation(
      end: .98,
      onTap: () {
        context.push(
          AzkarScreen(section: section),
          direction: NavigationDirection.upToDown,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        height: 85.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
            image: AssetImage(AppAssets.imagesGreenColor),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const Spacer(flex: 2),
            Text(
              section.title,
              style: AppStyles.style28l.copyWith(fontSize: 22.sp),
            ),
            const Spacer(),
            SvgPicture.asset(
              section.icon,
              fit: BoxFit.scaleDown,
              width: 60.w,
            ),
          ],
        ),
      ),
    );
  }
}

class LandscapeTabletAzkarSectionsItem extends StatelessWidget {
  const LandscapeTabletAzkarSectionsItem({super.key, required this.section});
  final AzkarSection section;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      end: .98,
      onTap: () {
        context.push(
          AzkarScreen(section: section),
          direction: NavigationDirection.upToDown,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            filterQuality: FilterQuality.low,
            image: AssetImage(AppAssets.imagesGreenColor),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: false,
              child: SvgPicture.asset(
                section.icon,
                fit: BoxFit.scaleDown,
                width: 30.w,
              ),
            ),
            Text(
              section.title,
              style: AppStyles.style28l.copyWith(fontSize: 18.sp),
            ),
            SvgPicture.asset(
              section.icon,
              fit: BoxFit.scaleDown,
              width: 30.w,
            ),
          ],
        ),
      ),
    );
  }
}
