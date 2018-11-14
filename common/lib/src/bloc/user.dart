import 'dart:async';

import 'package:flashcards_common/src/api/firebase.dart';
import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends Bloc {
  final FirebaseApi _api;

  final _createController = StreamController<UserData>();
  final _updateController = StreamController<UserData>();
  final _createIfAbsentController = StreamController<UserData>();

  UserBloc(this._api) {
    _createController.stream.listen(_handleCreate);
    _updateController.stream.listen(_handleUpdate);
    _createIfAbsentController.stream.listen(_handleCreateIfAbsent);
  }

  Sink<UserData> get create => _createController.sink;

  Sink<UserData> get update => _updateController.sink;

  Sink<UserData> get createIfAbsent => _createIfAbsentController.sink;

  Observable<UserData> query(String uid) {
    return _api.queryUser(uid);
  }

  Observable<List<UserData>> queryAll() {
    return _api.queryUsers();
  }

  void _handleCreate(UserData user) => _api.addUser(user);

  void _handleUpdate(UserData user) => _api.updateUser(user);

  void _handleCreateIfAbsent(UserData user) => _api.createIfAbsent(user);

  @override
  void dispose() {
    _createController.close();
    _updateController.close();
    _createIfAbsentController.close();
  }
}
