import 'dart:async';

import 'package:flashcards_logic/src/course_list_data.dart';
import 'package:flashcards_logic/src/firebase_api.dart';

export 'package:flashcards_logic/src/firebase_api.dart' show CoursesQueryType;

class CourseListBloc {
  final FirebaseApi _api;

  CourseListBloc(this._api);

  Stream<List<CourseListData>> query(CoursesQueryType type) {
    return _api.queryCourses(type: type);
  }
}
