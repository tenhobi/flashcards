import 'dart:async';

import 'package:flashcards_logic/src/course_list_data.dart';

enum CoursesQueryType { active, created, popular }

abstract class FirebaseApi {
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name});
}
