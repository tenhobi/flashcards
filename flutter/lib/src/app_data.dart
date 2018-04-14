import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppData extends InheritedWidget {
  final AuthenticationBloc<FirebaseUser> bloc;

  const AppData({@required this.bloc, Key key, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppData old) => bloc != old.bloc;

  static AppData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppData);
  }
}
