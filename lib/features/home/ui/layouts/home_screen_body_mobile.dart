import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/widgets/full_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_assets.dart';
import '../../../../core/widgets/top_bar_widget.dart';
import '../widgets/mobile_home_sections_list.dart';

class HomeScreenBodyMobile extends StatelessWidget {
  const HomeScreenBodyMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight,
      child: Stack(
        children: [
          const FullImage(image: AppAssets.imagesWhiteBackground),
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: TopBar(height: 160.h, withBackButton: false),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * .1,
                ),
                sliver: const MobileHomeSectionsList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
