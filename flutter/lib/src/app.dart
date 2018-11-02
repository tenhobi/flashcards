import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/i18n/fallback_localization_delegate.dart';
import 'package:flashcards_flutter/src/screen/about.dart';
import 'package:flashcards_flutter/src/screen/search.dart';
import 'package:flashcards_flutter/src/screen/settings.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/i18n/delegate.dart';
import 'package:flashcards_flutter/src/screen/landing.dart';
import 'package:flashcards_flutter/src/screen/main.dart';

// These two imports are used just in main, to set things up
import 'package:flutter_localizations/flutter_localizations.dart';

class FlashcardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlashcardsStrings.appName(),
      home: LandingScreen(
        nextScreen: MainScreen(),
      ),
      localizationsDelegates: [
        FlashcardsLocalizationDelegate(),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        FallbackLocalizationDelegate(),
      ],
      supportedLocales: supportedLocales,
      routes: <String, WidgetBuilder>{
        AboutScreen.route: (context) => AboutScreen(),
        MainScreen.route: (context) => MainScreen(),
        SearchScreen.route: (context) => SearchScreen(),
        SettingsScreen.route: (context) => SettingsScreen(),
      },
    );
  }
}
