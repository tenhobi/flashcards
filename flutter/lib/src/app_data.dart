import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppData extends InheritedWidget {
  FirebaseUser user;

  AppData({this.user, Key key, @required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppData old) => user != old.user;

  static AppData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppData);
  }
}
