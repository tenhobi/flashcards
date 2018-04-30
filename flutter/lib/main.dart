import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/common.dart';
import 'package:flashcards_flutter/src/inherited/app_data.dart';
import 'package:flashcards_flutter/src/api/authentication_flutter_api.dart';
import 'package:flashcards_flutter/src/api/firebase_flutter_api.dart';
import 'package:flashcards_flutter/src/i18n/delegate.dart';
import 'package:flutter/material.dart';

// These two imports are used just in main, to set things up
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flashcards_common/i18n.dart';

import 'package:flashcards_flutter/src/screen/landing.dart';
import 'package:flashcards_flutter/src/screen/main.dart';

// ignore: unused_import
import 'package:intl/intl.dart';

void loadLocales() {
  final List<String> locales = <String>[];
  for (Locale locale in supportedLocales) {
    locales.add(locale.toString());
  }
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
    final FirebaseApi firebaseApi = FirebaseFlutterApi();

    return AppData(
      authBloc: AuthenticationBloc<FirebaseUser>(AuthenticationFlutterApi()),
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
