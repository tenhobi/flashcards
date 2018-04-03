import 'dart:async';

import 'package:flashcards_logic/src/course_list_data.dart';
import 'package:flashcards_logic/src/api/firebase.dart';

export 'package:flashcards_logic/src/api/firebase.dart' show CoursesQueryType;

class CourseListBloc {
  final FirebaseApi _api;

  CourseListBloc(this._api);

  Stream<List<CourseData>> query(CoursesQueryType type) {
    return _api.queryCourses(type: type);
  }

  void create(CourseData course) => _api.addCourse(course);
}
