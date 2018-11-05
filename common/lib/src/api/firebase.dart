import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/data/comment.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:flashcards_common/src/data/user.dart';
import 'package:flashcards_common/src/data/exercise.dart';
import 'package:flashcards_common/src/data/question.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

enum CoursesQueryType { all, created, popular }

@immutable
abstract class FirebaseApi {
  void like({@required CourseData course, @required String userUid});

  void unlike({@required CourseData course, @required String userUid});

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

  void addComment({@required CourseData course, @required CommentData comment});

  void likeComment({@required CourseData course, @required CommentData comment, @required String authorUid});

  void unlikeComment({@required CourseData course, @required CommentData comment, @required String authorUid});

  BehaviorSubject<List<CourseData>> queryCourses({CoursesQueryType type, String name, String authorUid});

  BehaviorSubject<List<String>> queryStars({@required CourseData course});

  BehaviorSubject<List<CommentData>> queryComments(CourseData course);

  BehaviorSubject<List<String>> queryCommentsStars({CourseData course, CommentData comment});

  BehaviorSubject<List<QuestionData>> queryQuestions({ExerciseData exercise, int size});

  BehaviorSubject<List<SectionData>> querySections({@required CourseData course});

  BehaviorSubject<List<SubsectionData>> queryMaterials({@required SectionData section});

  BehaviorSubject<List<SubsectionData>> queryExercises({@required SectionData section});

  BehaviorSubject<UserData> queryUser(String uid);

  BehaviorSubject<List<UserData>> queryUsers();
}
