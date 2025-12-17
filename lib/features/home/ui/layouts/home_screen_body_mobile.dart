import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_assets.dart';
import '../../../../core/widgets/top_bar_widget.dart';
import '../widgets/mobile_home_sections_list.dart';

class HomeScreenBodyMobile extends StatelessWidget {
  const HomeScreenBodyMobile({super.key});

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
          child: TopBar(height: 160.h, withBackButton: false),
        ),
        Positioned.fill(
          top: 160.h,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * .1,
                ),
                sliver: const MobileHomeSectionsList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
