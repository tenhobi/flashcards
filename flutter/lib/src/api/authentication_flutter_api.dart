import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/api.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationFlutterApi extends AuthenticationApi {
  final FirebaseAuth _firebaseSignIn = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<String> signIn() async {
    final googleSignInAccount = await _googleSignIn.signIn();

    if (googleSignInAccount == null) {
      return null;
    }

    final gSA = await googleSignInAccount.authentication;
    final user = await _firebaseSignIn.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);

    return user.uid;
  }

  @override
  Future<String> signInSilently() async {
    final googleSignInAccount = await _googleSignIn.signInSilently();

    if (googleSignInAccount == null) {
      print('api: sign in silently - null');
      return null;
    }

    final gSA = await googleSignInAccount.authentication;
    final user = await _firebaseSignIn.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);

    print('api: sign in silently - $user');

    return user.uid;
  }

  @override
  Future signOut() async {
    await _googleSignIn.signOut();
    await _firebaseSignIn.signOut();
  }
}
