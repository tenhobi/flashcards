import 'dart:async';

import 'package:flashcards_common/common.dart';

class AuthenticationBloc<FirebaseUser> {
  final AuthenticationApi _api;

  FirebaseUser _user;

  AuthenticationBloc(this._api);

  FirebaseUser get user => _user;

  Future<FirebaseUser> signIn() async => _user = await _api.signIn();

  Future<FirebaseUser> signInSilently() async => _user = await _api.signInSilently();

  void signOut() {
    _api.signOut();
    _user = null;
  }
}
