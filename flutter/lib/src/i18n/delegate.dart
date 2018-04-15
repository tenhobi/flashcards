// +-------------------------------------------------+
// |                                                 |
// | Do NOT edit, unless you know what you are doing |
// |                                                 |
// +-------------------------------------------------+

import 'dart:async';
import 'package:flashcards_flutter/src/i18n/strings.dart';
import 'package:flutter/material.dart';

List<Locale> supportedLocales = [
  new Locale('cs', 'CZ'),
  new Locale('en', 'US'),
];

class FlashcardsLocalizationDelegate extends LocalizationsDelegate<FlutterFlashcardsStrings> {
  @override
  Future<FlutterFlashcardsStrings> load(Locale locale) => FlutterFlashcardsStrings.load(locale);

  @override
  isSupported(Locale locale) => supportedLocales.contains(locale);

//  bool isSupported(Locale locale) {
//    print(locale.languageCode);
//    print(supportedLanguages.contains(locale.languageCode));
//    return supportedLanguages.contains(locale.languageCode);
//  }

  @override
  bool shouldReload(FlashcardsLocalizationDelegate old) => false;
}
