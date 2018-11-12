import 'dart:async';

import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc extends Bloc {
  final AuthenticationApi _authApi;
  final FirebaseApi _firebaseApi;

  String _userUid;

  final _signInController = StreamController();
  final _signInSilentlyController = StreamController();
  final _signOutController = StreamController();

  AuthenticationBloc(this._authApi, this._firebaseApi) {
    _signInController.stream.listen(_handleSignIn);
    _signInSilentlyController.stream.listen(_handleSignInSilently);
    _signOutController.stream.listen(_handleSignOut);
  }

  Sink get signIn => _signInController.sink;

  Sink get signInSilently => _signInSilentlyController.sink;

  Sink<void> get signOut => _signOutController.sink;

  Future<void> _handleSignIn(_) async {
    _userUid = await _authApi.signIn();
    print('signin $_userUid');
  }

  Future<void> _handleSignInSilently(_) async {
    _userUid = await _authApi.signInSilently();
    print('signinsilently $_userUid');
  }

  void _handleSignOut(_) {
    _authApi.signOut();
    _userUid = null;
  }

  Observable<UserData> signedUser() {
    return _firebaseApi.queryUser(_userUid);
  }

  @override
  void dispose() {
    _signInController.close();
    _signInSilentlyController.close();
    _signOutController.close();
  }
}
