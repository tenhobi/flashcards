import 'dart:async';

import 'package:flashcards_common/src/api/authentication.dart';

class AuthenticationBloc<FirebaseUser> {
  final AuthenticationApi _api;

  FirebaseUser _user;

  Future<FirebaseUser> get user async => _user ?? await _api.signInSilently();

  Future<FirebaseUser> signIn() async => _user = await _api.signIn();

  Future<FirebaseUser> signInSilently() async => _user = await _api.signInSilently();

  void signOut() {
    _api.signOut();
    _user = null;
  }

  AuthenticationBloc(this._api);
}
