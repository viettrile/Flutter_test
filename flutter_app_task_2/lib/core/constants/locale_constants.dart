import 'package:flutter/material.dart';

abstract class LocaleConstants {
  static const String path = 'assets/translations';
  static String getPath(Locale locale) => '$path/${locale.languageCode}.json';

  static const String currentLanguageCode = 'currentLanguageCode';
  static const String currentCountryCode = 'currentCountryCode';

  static const Locale vi = Locale('vi', 'VN');
  static const Locale en = Locale('en', 'US');
}
