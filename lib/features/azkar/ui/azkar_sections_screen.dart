import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/extensions/widgets_ext.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/widgets/adaptive_layout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/top_bar_widget.dart';
import 'widgets/mobile_azkar_sections_item.dart';
import 'widgets/tablet_azkar_sections_item.dart';

class AzkarSectionsScreen extends StatelessWidget {
  const AzkarSectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.isLandscape
          ? const LandscapeAzkarSectionsScreenBody()
          : const AzkarSectionsScreenBody(),
    );
  }
}

class AzkarSectionsScreenBody extends StatelessWidget {
  const AzkarSectionsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppAssets.imagesWhiteBackground,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: TopBar(height: 280.h, label: 'الأذكار'),
        ),
        Positioned.fill(
          top: 320.h,
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * .105,
            ),
            itemCount: AzkarSection.values.length,
            itemBuilder: (context, index) {
              return AdaptiveLayout(
                mobileLayout: (context) => MobileAzkarSectionsItem(
                  section: AzkarSection.values[index],
                ),
                tabletLayout: (context) => TabletAzkarSectionsItem(
                  section: AzkarSection.values[index],
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
          ),
        )
      ],
    ).withSafeArea();
  }
}

class LandscapeAzkarSectionsScreenBody extends StatelessWidget {
  const LandscapeAzkarSectionsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppAssets.imagesWhiteBackground,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: TopBar(height: 350.h, label: 'الأذكار'),
        ),
        Positioned.fill(
          top: 400.h,
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * .105,
            ),
            itemCount: AzkarSection.values.length,
            itemBuilder: (context, index) {
              return AdaptiveLayout(
                mobileLayout: (context) => MobileAzkarSectionsItem(
                  section: AzkarSection.values[index],
                ),
                tabletLayout: (context) => TabletAzkarSectionsItem(
                  section: AzkarSection.values[index],
                ),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 20.h),
          ),
        )
      ],
    ).withSafeArea();
  }
}

enum AzkarSection {
  morning(icon: AppAssets.svgsSunIcon, title: 'أذكار الصباح'),
  evening(icon: AppAssets.svgsMoonIcon, title: 'أذكار المساء');

  final String icon, title;

  const AzkarSection({required this.icon, required this.title});
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
// import 'package:flutter_quran_app/core/theme/app_assets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../core/widgets/top_bar_widget.dart';
// import 'widgets/mobile_azkar_sections_item.dart';

// class AzkarSectionsScreen extends StatelessWidget {
//   const AzkarSectionsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarBrightness: Brightness.light,
//         statusBarIconBrightness: Brightness.light,
//       ),
//       child: Scaffold(
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(AppAssets.imagesWhiteBackground),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Column(
//                 spacing: 30.h,
//                 children: [
//                   TopBar(height: 280.h, label: 'الأذكار'),
//                   Expanded(
//                     child: ListView.separated(
//                       physics: const BouncingScrollPhysics(),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: context.screenWidth * .105,
//                       ),
//                       itemCount: AzkarSection.values.length,
//                       itemBuilder: (context, index) {
//                         return MobileAzkarSectionsItem(
//                           section: AzkarSection.values[index],
//                         );
//                       },
//                       separatorBuilder: (_, __) => SizedBox(height: 20.h),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// //         context.push(AzkarScreen(section: sections[index]));

// enum AzkarSection {
//   morning(icon: AppAssets.svgsSunIcon, title: 'أذكار الصباح'),
//   evening(icon: AppAssets.svgsMoonIcon, title: 'أذكار المساء');

//   final String icon, title;

//   const AzkarSection({required this.icon, required this.title});
// }
