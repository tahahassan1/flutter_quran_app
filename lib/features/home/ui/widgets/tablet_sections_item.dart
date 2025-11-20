import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_quran_app/features/quran/ui/quran_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../azkar/ui/azkar_sections_screen.dart';
import '../../../prayer_times/ui/prayer_times_screen.dart';
import '../../../qiblah/qiblah_screen.dart';
import '../../../quran_reciters/ui/quran_readers_screen.dart';
import '../../data/app_sections_enum.dart';

class TabletSectionsItem extends StatelessWidget {
  const TabletSectionsItem({super.key, required this.section});
  final AppSection section;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      end: .98,
      onTap: () {
        switch (section) {
          case AppSection.readers:
            context.push(const QuranReadersScreen());
            return;
          case AppSection.azkar:
            context.push(const AzkarSectionsScreen());
            return;
          case AppSection.prayersTime:
            context.push(const PrayerTimesScreen());
            return;
          
          case AppSection.qiblah:
            context.push(const QiblahScreen());
            return;
          case AppSection.quran:
            context.push(const QuranScreen());
            return;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        height: 90.h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppAssets.imagesGreenColor),
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            const Spacer(),
            Text(
              section.title,
              style: AppStyles.style28l,
            ),
            const Spacer(),
            SvgPicture.asset(
              section.icon,
              fit: BoxFit.scaleDown,
              width: 75.w,
            ),
          ],
        ),
      ),
    );
  }
}
