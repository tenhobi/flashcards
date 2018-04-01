import 'dart:async';

enum CoursesQueryType { active, created, popular }

abstract class FirebaseApi {
  Stream queryCourses({CoursesQueryType type, String name});
}
