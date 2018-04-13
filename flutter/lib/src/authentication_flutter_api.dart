import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/common.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationFlutterApi extends AuthenticationApi<FirebaseUser> {
  final FirebaseAuth firebaseSignIn = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return null;
    }

    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    _user = await firebaseSignIn.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);
    print('normal: $_user');
    return _user;
  }

  @override
  Future<FirebaseUser> signInSilently() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signInSilently();

    if (googleSignInAccount == null) {
      return null;
    }

    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    _user = await firebaseSignIn.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);
    print('silent: $_user');
    return _user;
  }

  @override
  void signOut() {
    googleSignIn.signOut();
    firebaseSignIn.signOut();
    print('User signed out.');
  }

  FirebaseUser _user;

  @override
  FirebaseUser get user => _user;
}
