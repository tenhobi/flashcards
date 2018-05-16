import 'dart:async';

import 'package:flashcards_common/src/api/authentication.dart';
import 'package:flashcards_common/src/bloc/bloc.dart';

class AuthenticationBloc<FirebaseUser> extends Bloc {
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

  @override
  void dispose() {}
}
