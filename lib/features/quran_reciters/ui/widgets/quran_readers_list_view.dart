import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/widgets/top_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/reciter_model.dart';
import 'reciter_widget.dart';
import 'reciters_search_bar.dart';

class ReadersListView extends StatelessWidget {
  const ReadersListView({super.key, required this.reciters});
  final List<ReciterModel> reciters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppAssets.imagesWhiteBackground),
        ),
      ),
      child: CustomScrollView(
        cacheExtent: 600,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 280.h,
              child: Stack(
                children: [
                  TopBar(
                    height: 260.h,
                    label: 'القـــراء',
                  ),
                  Positioned.fill(
                    top: context.isTablet ? 215.h : 190.h,
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: RecitersSearchBar(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (context.isTablet)
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverPrototypeExtentList(
            prototypeItem: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReciterWidget(reciter: reciters[0]),
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: reciters.length,
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ReciterWidget(reciter: reciters[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
