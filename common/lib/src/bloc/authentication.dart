import 'dart:async';

import 'package:flashcards_common/common.dart';

class AuthenticationBloc<FirebaseUser> {
  final AuthenticationApi _api;

  Future<FirebaseUser> signIn() async => _api.signIn();

  Future<FirebaseUser> signInSilently() async => _api.signInSilently();

  void signOut() => _api.signOut();

  FirebaseUser get user => _api.user;

  AuthenticationBloc(this._api);
}
