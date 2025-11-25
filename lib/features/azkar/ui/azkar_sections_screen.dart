import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/top_bar_widget.dart';
import 'widgets/mobile_azkar_sections_item.dart';

class AzkarSectionsScreen extends StatelessWidget {
  const AzkarSectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              AppAssets.imagesWhiteBackground,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              spacing: 30.h,
              children: [
                TopBar(
                  height: 280.h,
                  label: 'الأذكار',
                ),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * .105,
                    ),
                    itemCount: AzkarSection.values.length,
                    itemBuilder: (context, index) {
                      return MobileAzkarSectionsItem(
                        section: AzkarSection.values[index],
                      );
                    },
                    separatorBuilder: (_, __) => SizedBox(height: 20.h),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//         context.push(AzkarScreen(section: sections[index]));

enum AzkarSection {
  morning(icon: AppAssets.svgsSunIcon, title: 'أذكار الصباح'),
  evening(icon: AppAssets.svgsMoonIcon, title: 'أذكار المساء');

  final String icon, title;

  const AzkarSection({required this.icon, required this.title});
}
