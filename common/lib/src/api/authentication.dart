import 'dart:async';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationApi<FirebaseUser> {
  Future<FirebaseUser> signIn();

  Future<FirebaseUser> signInSilently();

  void signOut();
}
