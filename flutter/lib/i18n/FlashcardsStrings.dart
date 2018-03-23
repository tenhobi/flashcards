// +-------------------------------------------------+
// |                                                 |
// | Do NOT edit, unless you know what you are doing |
// |         except for adding new templates         |
// +-------------------------------------------------+

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import 'generated/flashcards_messages_all.dart';

class FlashcardsStrings {
  FlashcardsStrings(Locale locale) : _localeName = locale.toString();

  final String _localeName;

  String getLocale() => _localeName;

  static Future<FlashcardsStrings> load(Locale locale) {
    return initializeMessages(locale.toString()).then((Object _) {
      return new FlashcardsStrings(locale);
    });
  }

  static FlashcardsStrings of(BuildContext context) {
    return Localizations.of<FlashcardsStrings>(context, FlashcardsStrings);
  }

//  Edit here, do NOT touch anything above
  String title() {
    return Intl.message(
      'Flashcards',
      name: 'title',
      desc: 'App title',
      locale: _localeName,
    );
  }
}
