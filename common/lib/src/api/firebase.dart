import 'dart:async';

import 'package:flashcards_common/src/data/course.dart';

enum CoursesQueryType { active, created, popular }

abstract class FirebaseApi {
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name});

  void addCourse(CourseData course);
}
