import 'dart:async';

import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';

export 'package:flashcards_common/src/api/firebase.dart' show CoursesQueryType;

class CourseListBloc {
  final FirebaseApi _api;

  CourseListBloc(this._api);

  Stream<List<CourseData>> query(CoursesQueryType type) {
    return _api.queryCourses(type: type);
  }

  void create(CourseData course) => _api.addCourse(course);
}
