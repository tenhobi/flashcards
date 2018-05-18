import 'dart:async';

import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:meta/meta.dart';

export 'package:flashcards_common/src/api/firebase.dart' show CoursesQueryType;

class CourseListBloc extends Bloc {
  final FirebaseApi _api;

//  final StreamController<CourseData> _starController = StreamController<CourseData>();
//  final StreamController<CourseData> _unstarController = StreamController<CourseData>();
  final StreamController<CourseData> _createController = StreamController<CourseData>();
  final StreamController<CourseData> _removeController = StreamController<CourseData>();

  CourseListBloc(this._api) {
    _createController.stream.listen(_handleCreate);
    _removeController.stream.listen(_handleRemove);
  }

  Sink<CourseData> get create => _createController.sink;

  Sink<CourseData> get remove => _removeController.sink;

  Stream<List<CourseData>> queryAll(CoursesQueryType type, {String authorUid, String name}) {
    return _api.queryCourses(type: type, authorUid: authorUid, name: name);
  }

  Stream<List<String>> queryStars({@required CourseData course}) {
    return _api.queryStars(course: course);
  }

  void star(CourseData course, String userUid) => _api.star(course: course, userUid: userUid);

  void unstar(CourseData course, String userUid) => _api.unstar(course: course, userUid: userUid);

  void _handleCreate(CourseData course) => _api.addCourse(course);

  void _handleRemove(CourseData course) => _api.removeCourse(course);

  void dispose() {
    _createController.close();
    _removeController.close();
  }
}
