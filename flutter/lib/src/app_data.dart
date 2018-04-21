import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppData extends InheritedWidget {
  final AuthenticationBloc<FirebaseUser> authBloc;
  final CourseListBloc courseBloc;
  final UserBloc userBloc;

  const AppData({
    @required this.authBloc,
    @required this.courseBloc,
    @required this.userBloc,
    Key key,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppData old) => authBloc != old.authBloc || courseBloc != old.courseBloc;

  static AppData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppData);
  }
}
