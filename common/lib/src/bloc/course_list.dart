import 'dart:async';

import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

export 'package:flashcards_common/src/api/firebase.dart' show CoursesQueryType;

class CourseListBloc extends Bloc {
  final FirebaseApi _api;

  final StreamController<Tuple2<CourseData, String>> _likeController = StreamController();
  final StreamController<Tuple2<CourseData, String>> _unlikeController = StreamController();
  final StreamController<CourseData> _createController = StreamController();
  final StreamController<CourseData> _removeController = StreamController();

  CourseListBloc(this._api) {
    _likeController.stream.listen(_handleLike);
    _unlikeController.stream.listen(_handleUnlike);
    _createController.stream.listen(_handleCreate);
    _removeController.stream.listen(_handleRemove);
  }

  Sink<Tuple2<CourseData, String>> get like => _likeController.sink;

  Sink<Tuple2<CourseData, String>> get unlike => _unlikeController.sink;

  Sink<CourseData> get create => _createController.sink;

  Sink<CourseData> get remove => _removeController.sink;

  Stream<List<CourseData>> queryAll(CoursesQueryType type, {String authorUid, String name}) {
    return _api.queryCourses(type: type, authorUid: authorUid, name: name);
  }

  Stream<List<String>> queryStars({@required CourseData course}) {
    return _api.queryStars(course: course);
  }

  void _handleLike(Tuple2<CourseData, String> data) => _api.like(course: data.item1, userUid: data.item2);

  void _handleUnlike(Tuple2<CourseData, String> data) => _api.unlike(course: data.item1, userUid: data.item2);

  void _handleCreate(CourseData course) => _api.addCourse(course);

  void _handleRemove(CourseData course) => _api.removeCourse(course);

  @override
  void dispose() {
    _likeController.close();
    _unlikeController.close();
    _createController.close();
    _removeController.close();
  }
}
