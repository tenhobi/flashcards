import 'dart:async';

import 'package:flashcards_common/src/api/firebase.dart';
import 'package:flashcards_common/src/data/user.dart';

class UserBloc {
  final FirebaseApi _api;

  UserBloc(this._api);

  Stream<UserData> query(String uid) {
    return _api.queryUser(uid);
  }

  Stream<List<UserData>> queryAll() {
    return _api.queryUsers();
  }

  void create(UserData user) => _api.addUser(user);

  void updateUser(UserData user) => _api.updateUser(user);

  void createIfAbsent(UserData user) => _api.createIfAbsent(user);
}
