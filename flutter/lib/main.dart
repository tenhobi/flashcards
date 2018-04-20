import 'package:flashcards_common/common.dart';
import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flashcards_flutter/src/authentication_flutter_api.dart';
import 'package:flashcards_flutter/src/firebase_flutter_api.dart';
import 'package:flashcards_flutter/src/i18n/delegate.dart';
import 'package:flutter/material.dart';

// These two imports are used just in main, to set things up
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flashcards_common/i18n.dart';

import 'package:flashcards_flutter/src/landing_screen.dart';
import 'package:flashcards_flutter/src/main_screen.dart';

// ignore: unused_import
import 'package:intl/intl.dart';

void loadLocales() {
  List<String> locales = List<String>();
  supportedLocales.forEach((l) => locales.add(l.toString()));
  initLocales(locales);
}

void main() {
  loadLocales();
//  Example of setting default locale
//  Intl.defaultLocale = 'cs_CZ';
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseApi firebaseApi = FirebaseFlutterApi();

    return AppData(
      authBloc: AuthenticationBloc(AuthenticationFlutterApi()),
      courseBloc: CourseListBloc(firebaseApi),
      userBloc: UserBloc(firebaseApi),
      child: MaterialApp(
        title: 'Flashcards',
        home: LandingScreen(
          nextScreen: MainScreen(),
          nextNewUserScreen: MainScreen(),
        ),
        localizationsDelegates: [
          new FlashcardsLocalizationDelegate(),
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: supportedLocales,
      ),
    );
  }
}
