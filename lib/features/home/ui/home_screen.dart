import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quran_app/core/helpers/app_initializer.dart';
import 'package:flutter_quran_app/features/home/ui/layouts/home_screen_body_mobile.dart';

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    Future.delayed(const Duration(milliseconds: 600), () {
      AppInitializer.homeInit();
    });
    super.initState();
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
