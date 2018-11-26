import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_common/data.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFlutterApi extends FirebaseApi {
  @override
  void addComment({CourseData course, CommentData comment}) {
    // TODO: implement addComment
  }

  @override
  void addCourse(CourseData course) {
    // TODO: implement addCourse
  }

  @override
  void addSection(SectionData section) {
    // TODO: implement addSection
  }

  @override
  void addSubsection(SubsectionData subsection) {
    // TODO: implement addSubsection
  }

  @override
  void addUser(UserData user) {
    // TODO: implement addUser
  }

  @override
  void createIfAbsent(UserData user) {
    // TODO: implement createIfAbsent
  }

  @override
  void editSection(SectionData section) {
    // TODO: implement editSection
  }

  @override
  void editSubsection(SubsectionData subsection) {
    // TODO: implement editSubsection
  }

  @override
  void like({CourseData course, String userUid}) {
    // TODO: implement like
  }

  @override
  void likeComment({CourseData course, CommentData comment, String authorUid}) {
    // TODO: implement likeComment
  }

  @override
  Observable<List<CommentData>> queryComments(CourseData course) {
    // TODO: implement queryComments
    return null;
  }

  @override
  Observable<List<String>> queryCommentsStars({CourseData course, CommentData comment}) {
    // TODO: implement queryCommentsStars
    return null;
  }

  @override
  Observable<List<CourseData>> queryCourses({CoursesQueryType type, String name, String authorUid}) {
    // TODO: implement queryCourses
    return null;
  }

  @override
  Observable<List<SubsectionData>> queryExercises({SectionData section}) {
    // TODO: implement queryExercises
    return null;
  }

  @override
  Observable<List<SubsectionData>> queryMaterials({SectionData section}) {
    // TODO: implement queryMaterials
    return null;
  }

  @override
  Observable<List<QuestionData>> queryQuestions({ExerciseData exercise, int size}) {
    // TODO: implement queryQuestions
    return null;
  }

  @override
  Observable<List<SectionData>> querySections({CourseData course}) {
    // TODO: implement querySections
    return null;
  }

  @override
  Observable<List<String>> queryStars({CourseData course}) {
    // TODO: implement queryStars
    return null;
  }

  @override
  Observable<UserData> queryUser(String uid) {
    // TODO: implement queryUser
    return null;
  }

  @override
  Observable<List<UserData>> queryUsers() {
    // TODO: implement queryUsers
    return null;
  }

  @override
  void removeCourse(CourseData course) {
    // TODO: implement removeCourse
  }

  @override
  void removeSection(SectionData section) {
    // TODO: implement removeSection
  }

  @override
  void removeSubsection(SubsectionData subsection) {
    // TODO: implement removeSubsection
  }

  @override
  void unlike({CourseData course, String userUid}) {
    // TODO: implement unlike
  }

  @override
  void unlikeComment({CourseData course, CommentData comment, String authorUid}) {
    // TODO: implement unlikeComment
  }

  @override
  void updateUser(UserData user) {
    // TODO: implement updateUser
  }
}
