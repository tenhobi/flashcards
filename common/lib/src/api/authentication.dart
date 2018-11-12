import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationApi {
  Future<String> signIn();

  Future<String> signInSilently();

  void signOut();
}
