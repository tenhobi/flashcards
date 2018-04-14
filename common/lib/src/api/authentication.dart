import 'dart:async';

abstract class AuthenticationApi<FirebaseUser> {
  FirebaseUser get user;

  Future<FirebaseUser> signIn();

  Future<FirebaseUser> signInSilently();

  void signOut();
}
