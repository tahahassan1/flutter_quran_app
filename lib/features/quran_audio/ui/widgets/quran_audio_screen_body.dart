import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/helpers/alert_helper.dart';
import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/functions.dart'
    show changeBrightness;
import 'package:flutter_quran_app/core/theme/app_assets.dart';
import 'package:flutter_quran_app/core/widgets/adaptive_layout.dart';
import 'package:flutter_quran_app/features/quran_audio/logic/quran_player/quran_player_cubit.dart';
import 'package:flutter_quran_app/features/quran_reciters/data/models/reciter_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text_widget.dart';
import '../../../../core/widgets/full_image.dart';
import 'bottom_sheet_bloc_builder.dart';
import 'quran_list_view.dart';

class QuranAudioScreenBody extends StatefulWidget {
  const QuranAudioScreenBody({super.key, required this.reciter});

  final ReciterModel reciter;

  @override
  State<QuranAudioScreenBody> createState() => _QuranAudioScreenBodyState();
}

class _QuranAudioScreenBodyState extends State<QuranAudioScreenBody> {
  @override
  void initState() {
    changeBrightness(Brightness.dark);
    super.initState();
  }

  @override
  void dispose() {
    changeBrightness(Brightness.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuranPlayerCubit, QuranPlayerState>(
      listener: (context, state) {
        if (state is QuranPlayerFailure) {
          AlertHelper.showErrorAlert(
            context,
            message: state.errMessage ?? 'حدث خطأ ما',
          );
        }
      },
      child: AdaptiveLayout(
        mobileLayout: (_) => MobileQuranAudioLayout(reciter: widget.reciter),
        tabletLayout: (_) => TabletQuranAudioLayout(reciter: widget.reciter),
      ),
    );
  }
}

class TabletQuranAudioLayout extends StatelessWidget {
  const TabletQuranAudioLayout({super.key, required this.reciter});

  final ReciterModel reciter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight,
      child: Stack(
        children: [
          const FullImage(image: AppAssets.imagesFullWhiteBackground),
          Positioned.fill(
            top: 120.h,
            child: QuranListView(qaree: reciter),
          ),
          Positioned.fill(
            top: 80.h,
            child: Align(
              alignment: Alignment.topCenter,
              child: CustomTextWidget(text: reciter.name, fontSize: 18.sp),
            ),
          ),
          Positioned.fill(
            bottom: 40,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SurahOverlayPlayerBuilder(qaree: reciter),
            ),
          ),
        ],
      ),
    );
  }
}

class MobileQuranAudioLayout extends StatelessWidget {
  const MobileQuranAudioLayout({super.key, required this.reciter});

  final ReciterModel reciter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      height: context.screenHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppAssets.imagesFullWhiteBackground),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  top: 15.h,
                  child: QuranListView(qaree: reciter),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomTextWidget(text: reciter.name),
                ),
                Positioned.fill(
                  bottom: 40,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SurahOverlayPlayerBuilder(qaree: reciter),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
