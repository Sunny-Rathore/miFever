import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import 'en_us/app_es.dart';
import 'en_us/app_pt.dart';
import 'en_us/en_us_translations.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('en', 'US');

  static final locales = [
    const Locale('en'),
    const Locale('es'),
    const Locale('pt'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUs,
        'es': esES,
        'pt': ptBr,
      };

  // Gets locale from language, and updates the locale
  static void changeLocale(String lang) async {
    await PrefUtils.setLang(lang);
    Get.updateLocale(Locale(lang));
  }

  static Future<void> loadSavedLocale() async {
    final String savedLang = PrefUtils.getLang();
    Get.updateLocale(Locale(savedLang));
  }
}
