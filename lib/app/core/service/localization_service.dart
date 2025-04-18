import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lang/app_ar.dart';
import '../lang/app_en.dart';

class LocalizationService extends Translations {
  /// Default locale
  static const Locale defaultLocale = Locale('en', 'US');

  /// Fallback locale (if selected locale is unsupported)
  static const Locale fallbackLocale = Locale('en', 'US');

  /// Supported locales
  static final List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'EG'),
  ];

  /// Language key-value pairs
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS,
    'ar_EG': arEG,
  };

  /// Update language dynamically
  static void changeLocale(String langCode) {
    final selectedLocale = supportedLocales.firstWhere(
          (locale) => locale.languageCode == langCode,
      orElse: () => defaultLocale,
    );

    Get.updateLocale(selectedLocale);
  }
}
