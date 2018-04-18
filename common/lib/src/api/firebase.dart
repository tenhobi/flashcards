import 'dart:async';

import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:meta/meta.dart';

enum CoursesQueryType { active, created, popular }

@immutable
abstract class FirebaseApi {
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name});
  Stream<List<SectionData>> querySections({@required CourseData course});

  void addCourse(CourseData course);
}
