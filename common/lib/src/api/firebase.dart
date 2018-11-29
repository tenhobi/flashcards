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
  void addComment({@required CourseData course, @required CommentData comment});

  void addCourse(CourseData course);

  void addUser(UserData user);

  void addSection(SectionData section);

  void addSubsection(SubsectionData subsection);

  void addQuestion(QuestionData question);

  void createIfAbsent(UserData user);

  void editSection(SectionData section);

  void editSubsection(SubsectionData subsection);

  void editQuestion(QuestionData question);

  void like({@required CourseData course, @required String userUid});

  void likeComment({@required CourseData course, @required CommentData comment, @required String authorUid});

  void unlike({@required CourseData course, @required String userUid});

  void unlikeComment({@required CourseData course, @required CommentData comment, @required String authorUid});

  void updateUser(UserData user);

  void removeCourse(CourseData course);

  void removeSection(SectionData section);

  void removeSubsection(SubsectionData subsection);

  void removeQuestion(QuestionData question);

  Observable<List<CourseData>> queryCourses({CoursesQueryType type, String name, String authorUid});

  Observable<List<CommentData>> queryComments(CourseData course);

  Observable<List<String>> queryCommentsStars({CourseData course, CommentData comment});

  Observable<List<SubsectionData>> queryExercises({@required SectionData section});

  Observable<List<QuestionData>> queryQuestions({ExerciseData exercise, int size});

  Observable<List<SubsectionData>> queryMaterials({@required SectionData section});

  Observable<List<String>> queryStars({@required CourseData course});

  Observable<List<SectionData>> querySections({@required CourseData course});

  Observable<UserData> queryUser(String uid);

  Observable<List<UserData>> queryUsers();
}
