// +-------------------------------------------------+
// |                                                 |
// | Do NOT edit, unless you know what you are doing |
// |                                                 |
// +-------------------------------------------------+

import 'dart:async';
import 'package:flutter/material.dart';

import 'flashcards_strings.dart';

List<Locale> supportedLocales = [
  new Locale("cs", "CZ"),
  new Locale("en", "US"),
];

class FlashcardsLocalizationDelegate
    extends LocalizationsDelegate<FlashcardsStrings> {
  @override
  Future<FlashcardsStrings> load(Locale locale) =>
      FlashcardsStrings.load(locale);

  @override
  isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  bool shouldReload(FlashcardsLocalizationDelegate old) => false;
}
