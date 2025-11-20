import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/di/di.dart';
import 'package:flutter_quran_app/core/networking/dio_consumer.dart';
import 'package:flutter_quran_app/features/quran_reciters/data/models/reciter_model.dart';

import '../../../../core/networking/api_keys.dart';
import '../../data/models/surah_audio_model.dart';

part 'quran_state.dart';

class QuranAudioCubit extends Cubit<QuranState> {
  QuranAudioCubit(this.reciter) : super(QuranInitial());
  final ReciterModel reciter;

  List<SurahAudioModel> quran = [];

  Future<List<SurahAudioModel>> getQuran(int qareeId) async {
    emit(QuranLoading());
    try {
      var response = await getIt<DioConsumer>().get(
        '${reciter.moshafList[0].server}/$qareeId',
      );

      List quranAsMaps = response.data['data'][ApiKeys.audioFiles];

      quran = quranAsMaps.map((e) => SurahAudioModel.fromJson(e)).toList();

      emit(QuranSuccess());

      return quran;
    } on DioException catch (e) {
      emit(QuranFailure(errMessage: e.message ?? 'هناك خطأ'));
      return [];
    }
  }
}
