import 'dart:async';

abstract class AuthenticationApi<FirebaseUser> {
  FirebaseUser _user;

  FirebaseUser get user;

  Future<FirebaseUser> signIn();

  Future<FirebaseUser> signInSilently();

  void signOut();
}
