import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quran_app/core/helpers/extensions/app_navigator.dart';

import '../../../core/theme/app_assets.dart';
import '../../azkar/ui/azkar_sections_screen.dart';
import '../../prayer_times/ui/prayer_times_screen.dart';
import '../../qiblah/qiblah_screen.dart';
import '../../quran/ui/quran_screen.dart';
import '../../quran_reciters/ui/quran_readers_screen.dart';

enum AppSection {
  quran(
    icon: AppAssets.sectionsQuran,
    title: 'القرآن الكريم',
  ),
  readers(
    icon: AppAssets.sectionsReciters,
    title: 'القــــــــــــــــــراء',
  ),

  azkar(
    icon: AppAssets.sectionsAzkar,
    title: 'الأذكــــــــــــــــــار',
  ),
  qiblah(
    icon: AppAssets.sectionsQiblah,
    title: 'القــــــــــــــــــبلة',
  ),
  prayersTime(
    icon: AppAssets.sectionsPrayer,
    title: 'أوقات الصـلاة',
  ),
  ;

  void push(BuildContext context) async {
    switch (this) {
      case AppSection.quran:
        {
          await SystemChrome.setPreferredOrientations([]);
          if (context.mounted) {
            context.push(const QuranScreen());
          }
        }
        return;
      case AppSection.readers:
        context.push(const QuranReadersScreen());
        return;
      case AppSection.azkar:
        context.push(const AzkarSectionsScreen());
        return;
      case AppSection.prayersTime:
        context.push(const PrayerTimesScreen());
        return;

      case AppSection.qiblah:
        context.push(const QiblahScreen());
        return;
    }
  }

  final String icon, title;

  const AppSection({required this.icon, required this.title});
}
