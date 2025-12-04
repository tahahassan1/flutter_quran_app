import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/features/prayer_times/data/models/prayer_times_model.dart';

import '../../../../core/theme/app_assets.dart';
import '../../logic/prayer_times_cubit/prayer_times_cubit.dart';
import 'prayer_times_date_widget.dart';
import 'prayer_times_grid_view.dart';
import 'prayer_times_header.dart';
import 'user_location_widget.dart';

class PrayerTimesScreenBody extends StatelessWidget {
  const PrayerTimesScreenBody({
    super.key,
    required this.nextPrayer,
  });
  final PrayerTimeModel nextPrayer;

  @override
  Widget build(BuildContext context) {
    final prayers = context.read<PrayerTimesCubit>().prayers!;
    return Stack(
      children: [
        Image.asset(
          AppAssets.imagesWhiteBackground,
          fit: BoxFit.cover,
          height: double.infinity,
        ),
        CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: PrayerTimesHeader(
                isMorning: nextPrayer.prayerType.isMorning,
              ),
            ),
            SliverToBoxAdapter(
              child: Center(child: PrayerTimesDateWidget(prayers: prayers)),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: context.screenWidth * 0.1,
              ),
              sliver: PrayerTimesGridView(
                prayers: prayers,
                nextPrayer: nextPrayer,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            if (prayers.location.arabicAddress != null ||
                prayers.location.address != null)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.screenWidth * 0.1,
                ),
                sliver: SliverToBoxAdapter(
                  child: UserLocationWidget(
                    location: prayers.location.arabicAddress ??
                        prayers.location.address!,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ],
    );
  }
}
