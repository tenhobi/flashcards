import 'dart:async';

import 'package:flashcards_common/src/data/course.dart';
import 'package:meta/meta.dart';

enum CoursesQueryType { active, created, popular }

@immutable
abstract class FirebaseApi {
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name});

  void addCourse(CourseData course);
}
