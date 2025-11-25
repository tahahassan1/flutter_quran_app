import 'package:flutter/material.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';

import 'quran_readers_bloc_builder.dart';

class QuranReadersScreenBody extends StatelessWidget {
  const QuranReadersScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: context.screenHeight,
      child: const ReadersBlocBuilder(),
    );
  }
}
