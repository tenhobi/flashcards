import 'dart:async';

import 'package:firebase/firebase.dart' as fb;
import 'package:flashcards_common/api.dart';

class AuthenticationAngularApi extends AuthenticationApi {
  @override
  Future<String> signIn() async {
    var _fbGoogleAuthProvider = fb.GoogleAuthProvider();
    var _fbAuth = fb.auth();

    try {
      var user = await _fbAuth.signInWithRedirect(_fbGoogleAuthProvider);
      return user.user.uid;
    } on Error catch (error) {
      print("$runtimeType::signIn() -- $error");
    }

    return null;
  }

  @override
  Future<String> signInSilently() {
    return signIn();
  }

  @override
  Future<void> signOut() {
    var _fbAuth = fb.auth();
    return _fbAuth.signOut();
  }
}
