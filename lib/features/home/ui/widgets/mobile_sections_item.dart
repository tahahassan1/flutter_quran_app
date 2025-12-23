import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/theme/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/app_sections_enum.dart';

class MobileSectionsItem extends StatelessWidget {
  const MobileSectionsItem({
    super.key,
    required this.section,
  });
  final AppSection section;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      end: .98,
      onTap: () => section.push(context),
      child: Container(
        padding: EdgeInsets.all(16.w),
        height: 100.h,
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
            const Spacer(),
            Text(
              section.title,
              style: AppStyles.style28l,
            ),
            const Spacer(),
            VectorGraphic(
              loader: AssetBytesLoader(section.icon),
              width: 80.w,
              fit: BoxFit.scaleDown,
            )
          ],
        ),
      ),
    );
  }
}
