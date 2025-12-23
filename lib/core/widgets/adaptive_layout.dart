import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';

import '../helpers/size_config.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({
    super.key,
    required this.mobileLayout,
    this.tabletLayout,
  });
  final WidgetBuilder mobileLayout;
  final WidgetBuilder? tabletLayout;

  @override
  Widget build(BuildContext context) {
    final actualWidth =
        context.isLandscape ? context.screenHeight : context.screenWidth;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (actualWidth < SizeConfig.tablet) {
          return mobileLayout(context);
        } else {
          if (tabletLayout != null) {
            return tabletLayout!(context);
          } else {
            return mobileLayout(context);
          }
        }
      },
    );
  }
}
