import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_flutter/src/app.dart';
import 'package:flashcards_flutter/src/api/authentication_flutter_api.dart';
import 'package:flashcards_flutter/src/api/firebase_flutter_api.dart';
import 'package:flashcards_flutter/src/i18n/delegate.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/i18n.dart';

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

  final FirebaseApi firebaseApi = FirebaseFlutterApi();

  runApp(StateContainer(
    authenticationBloc: AuthenticationBloc<FirebaseUser>(AuthenticationFlutterApi()),
    courseListBloc: CourseListBloc(firebaseApi),
    userBloc: UserBloc(firebaseApi),
    child: FlashcardsApp(),
  ));
}
