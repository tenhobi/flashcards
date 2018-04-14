import 'package:flutter/material.dart';

// These two imports are used just in main, to set things up
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i18n/FlashcardsDelegate.dart';

// This will be imported everywhere you need localized string
import 'i18n/FlashcardsStrings.dart';

import 'package:flashcards_flutter/src/landing_screen.dart';
import 'package:flashcards_flutter/src/main_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: FlashcardsStrings.of(context).title(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LandingScreen(nextScreen: new MainScreen()),
      localizationsDelegates: [
        new FlashcardsLocalizationDelegate(),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
    );
  }
}
