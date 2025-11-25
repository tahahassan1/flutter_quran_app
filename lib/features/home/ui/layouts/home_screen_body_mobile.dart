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
    return Container(
      width: context.screenWidth,
      height: context.screenHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.imagesWhiteBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: TopBar(
              height: 160.h,
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: context.screenWidth * .1),
            sliver: const MobileHomeSectionsList(),
          ),
        ],
      ),
    );
  }
}
