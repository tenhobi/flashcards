// +-------------------------------------------------+
// |                                                 |
// | Do NOT edit, unless you know what you are doing |
// |                                                 |
// +-------------------------------------------------+

import 'dart:async';
import 'package:flashcards_flutter/src/i18n/strings.dart';
import 'package:flutter/material.dart';

const List<Locale> supportedLocales = [
  Locale('cs', 'CZ'),
  Locale('en', 'US'),
];

class FlashcardsLocalizationDelegate extends LocalizationsDelegate<FlutterFlashcardsStrings> {
  @override
  Future<FlutterFlashcardsStrings> load(Locale locale) => FlutterFlashcardsStrings.load(locale);

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  bool shouldReload(FlashcardsLocalizationDelegate old) => false;
}
