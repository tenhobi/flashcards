import 'dart:async';

import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/data/comment.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:flashcards_common/src/data/user.dart';
import 'package:flashcards_common/src/data/exercise.dart';
import 'package:flashcards_common/src/data/question.dart';
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

  Stream<UserData> queryUser(String uid);

  Stream<List<UserData>> queryUsers();

  void addCourse(CourseData course);

  void removeCourse(CourseData course);

  void addUser(UserData user);

  void updateUser(UserData user);

  void createIfAbsent(UserData user);

  void addSection(SectionData section);

  void removeSection(SectionData section);

  void editSection(SectionData section);

  void addSubsection(SubsectionData subsection);

  void removeSubsection(SubsectionData subsection);

  void editSubsection(SubsectionData subsection);

  Stream<List<CommentData>> queryComments(CourseData course);

  void addComment({@required CourseData course, @required CommentData comment});

  void likeComment({@required CourseData course, @required CommentData comment, @required String authorUid});

  void unlikeComment({@required CourseData course, @required CommentData comment, @required String authorUid});

  Stream<List<String>> queryCommentsStars({CourseData course, CommentData comment});

  Stream<List<QuestionData>> queryQuestions({ExerciseData exercise, int size});
}
