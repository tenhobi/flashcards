import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationFlutterApi extends AuthenticationApi<FirebaseUser> {
  final FirebaseAuth firebaseSignIn = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<FirebaseUser> signIn() async {
    final googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount == null) return null;

    final gSA = await googleSignInAccount.authentication;
    return firebaseSignIn.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);
  }

  @override
  Future<FirebaseUser> signInSilently() async {
    final googleSignInAccount = await googleSignIn.signInSilently();

    if (googleSignInAccount == null) return null;

    final gSA = await googleSignInAccount.authentication;
    return firebaseSignIn.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);
  }

  @override
  void signOut() {
    googleSignIn.signOut();
    firebaseSignIn.signOut();
  }
}
