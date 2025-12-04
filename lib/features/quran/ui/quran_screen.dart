import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran_app/core/di/di.dart';
import 'package:flutter_quran_app/core/helpers/extensions/screen_details.dart';
import 'package:flutter_quran_app/core/helpers/extensions/theme.dart';
import 'package:flutter_quran_app/core/services/cache_service.dart';
import 'package:flutter_quran_app/features/quran/bloc/quran/quran_cubit.dart';
import 'package:flutter_quran_app/features/quran/bloc/verse_player/verse_player_cubit.dart';
import 'package:flutter_quran_app/features/quran/data/repo/quran_repo.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/helpers/size_config.dart';
import 'widgets/quran_screen_body.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  int? _cachedPage;
  bool _isInitialized = false;

  @override
  void initState() {
    WakelockPlus.enable();
    _initializeCache();
    super.initState();
  }

  Future<void> _initializeCache() async {
    _cachedPage = getIt<CacheService>().getInt('last_quran_page');
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: context.primaryColor,
      resizeToAvoidBottomInset: false,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => QuranCubit(
              QuranRepo(
                tablet: context.screenWidth > SizeConfig.tablet,
                initialPage: _cachedPage,
              ),
            ),
          ),
          BlocProvider(create: (context) => VersePlayerCubit()),
        ],
        child: const SafeArea(
          top: true,
          bottom: false,
          right: false,
          left: false,
          child: QuranScreenBody(),
        ),
      ),
    );
  }
}
