import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/helpers/app_initializer.dart';
import 'package:flutter_quran_app/core/theme/theme_manager/theme_cubit.dart';

import 'features/quran/bloc/search/search_cubit.dart';
import 'features/quran_audio/logic/quran_player/quran_player_cubit.dart';
import 'quran_app.dart';

Future<bool> isAndroid12Plus() async {
  if (!Platform.isAndroid) return false;

  final info = await DeviceInfoPlugin().androidInfo;
  return info.version.sdkInt >= 31;
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isIOS) {
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  await AppInitializer.mainInit();
  final bool showCustomSplash = await isAndroid12Plus();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => QuranPlayerCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => SearchCubit()),
      ],
      child: QuranApp(showCustomSplash: showCustomSplash),
    ),
  );
}
