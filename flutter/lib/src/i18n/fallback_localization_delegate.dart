import 'dart:async';

import 'package:flutter/material.dart';

// Delegate for default localization if the selected locale is not supported.
class FallbackLocalizationDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;

  @override
  bool shouldReload(FallbackLocalizationDelegate old) => false;

  @override
  Future<MaterialLocalizations> load(Locale locale) => DefaultMaterialLocalizations.load(locale);
}
