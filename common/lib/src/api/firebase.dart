import 'dart:async';

import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:flashcards_common/src/data/user.dart';
import 'package:meta/meta.dart';

enum CoursesQueryType { all, created, popular }

@immutable
abstract class FirebaseApi {
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name, String authorUid});

  Stream<List<String>> queryStars({@required CourseData course});

  void like({@required CourseData course, @required String userUid});

  void unlike({@required CourseData course, @required String userUid});

  Stream<List<SectionData>> querySections({@required CourseData course});

  Stream<List<SubsectionData>> queryMaterials({@required SectionData section});

  Stream<List<SubsectionData>> queryExercises({@required SectionData section});

  void addCourse(CourseData course);

  Stream<UserData> queryUser(String uid);

  Stream<List<UserData>> queryUsers();

  void addUser(UserData user);

  void updateUser(UserData user);

  void createIfAbsent(UserData user);

  void addSection(SubsectionData section);

  void removeCourse(CourseData course);
}
