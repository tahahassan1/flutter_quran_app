import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quran_app/core/helpers/app_initializer.dart';
import 'package:flutter_quran_app/features/home/ui/layouts/home_screen_body_mobile.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../core/helpers/extensions/widgets_ext.dart';
import '../../../core/widgets/adaptive_layout.dart';
import 'layouts/home_screen_body_tablet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  @override
  void initState() {
    _removeSplash();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Future.delayed(const Duration(milliseconds: 600), () {
      AppInitializer.homeInit();
    });
    super.initState();
  }

  Future<void> _removeSplash() async {
    if (Platform.isIOS) {
      await Future.delayed(const Duration(milliseconds: 2400));
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (_) => const HomeScreenBodyMobile(),
        tabletLayout: (context) => const HomeScreenBodyTablet(),
      ).withSafeArea(),
    );
  }
}
