import 'dart:async';

import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc extends Bloc {
  final AuthenticationApi _authApi;
  final FirebaseApi _firebaseApi;

  String _userUid;

  final _signChangesSubject = BehaviorSubject<bool>();
  final _signInSubject = BehaviorSubject<void>();
  final _signInSilentlySubject = BehaviorSubject<void>();
  final _signOutSubject = BehaviorSubject<void>();

  AuthenticationBloc(this._authApi, this._firebaseApi) {
    _signInSubject.stream.listen(_handleSignIn);
    _signInSilentlySubject.stream.listen(_handleSignInSilently);
    _signOutSubject.stream.listen(_handleSignOut);
  }

  Sink<void> get _signChanges => _signChangesSubject.sink;

  Sink<void> get signIn => _signInSubject.sink;

  Sink<void> get signInSilently => _signInSilentlySubject.sink;

  Sink<void> get signOut => _signOutSubject.sink;

  Observable<bool> signChanges() => _signChangesSubject.stream;

  Future<void> _handleSignIn(_) async {
    _userUid = await _authApi.signIn();
    _signChanges.add(_userUid != null);
    print('auth bloc: signin $_userUid');
  }

  Future<void> _handleSignInSilently(_) async {
    _userUid = await _authApi.signInSilently();
    _signChanges.add(_userUid != null);
    print('auth bloc: signin silently $_userUid');
  }

  void _handleSignOut(_) async {
    await _authApi.signOut();
    _userUid = null;
    _signChanges.add(false);
    print('auth bloc: signout');
  }

  // TODO: somehow fix this so it changes the stream based on the [_userId] parameter.
  Observable<UserData> signedUser() => _firebaseApi.queryUser(_userUid);

  @override
  void dispose() {
    _signChangesSubject.close();
    _signInSubject.close();
    _signInSilentlySubject.close();
    _signOutSubject.close();
  }
}
