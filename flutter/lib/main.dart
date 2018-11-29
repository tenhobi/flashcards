import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/api/authentication_flutter_api.dart';
import 'package:flashcards_flutter/src/api/firebase_flutter_api.dart';
import 'package:flashcards_flutter/src/app.dart';
import 'package:flashcards_flutter/src/i18n/delegate.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

void loadLocales() {
  final locales = <String>[];
  for (var locale in supportedLocales) {
    locales.add(locale.toString());
  }
  initLocales(locales);
}

void main() {
  loadLocales();

  final FirebaseApi firebaseApi = FirebaseFlutterApi();

  runApp(StateContainer(
    authenticationBloc: AuthenticationBloc(AuthenticationFlutterApi(), firebaseApi),
    child: FlashcardsApp(),
    courseListBloc: CourseListBloc(firebaseApi),
    userBloc: UserBloc(firebaseApi),
    sectionListBloc: SectionListBloc(firebaseApi),
    exerciseBloc: ExerciseBloc(firebaseApi),
  ));
}
