import 'package:firebase/firebase.dart' as fb;
import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_common/data.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseAngularApi extends FirebaseApi {
  static final FirebaseAngularApi _instance = FirebaseAngularApi._();

  factory FirebaseAngularApi() => _instance;

  FirebaseAngularApi._();

  @override
  void addComment({CourseData course, CommentData comment}) {
    // TODO: implement addComment
  }

  @override
  void addCourse(CourseData course) {
    // TODO: implement addCourse
  }

  @override
  void addQuestion(QuestionData question) {
    // TODO: implement addQuestion
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
  void editQuestion(QuestionData question) {
    // TODO: implement editQuestion
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
  BehaviorSubject<List<CommentData>> queryComments(CourseData course) {
    final controller = BehaviorSubject<List<CommentData>>();

    fb.firestore().collection('courses').doc(course.id).collection('comments').onSnapshot.listen((snapshot) {
      controller.add(snapshot.docs.map<CommentData>((document) {
        final data = document.data();
        data['id'] = document.id;
        return CommentData.fromMap(data);
      }).toList());
    });

    return controller.stream;
  }

  @override
  Observable<List<String>> queryCommentsStars({CourseData course, CommentData comment}) {
    // TODO: implement queryCommentsStars
    return null;
  }

  @override
  Observable<List<CourseData>> queryCourses({CoursesQueryType type, String name, String authorUid}) {
    final controller = BehaviorSubject<List<CourseData>>();

    var courses = fb.firestore().collection('courses');

    switch (type) {
      case CoursesQueryType.created:
        courses = courses.where('authorUid', '==', authorUid).orderBy('name');
        break;
      case CoursesQueryType.popular:
      case CoursesQueryType.all:
      default:
    }

    courses.onSnapshot.listen((snapshot) {
      final dataList = snapshot.docs.map<CourseData>((document) {
        final documentData = document.data()..addAll(<String, dynamic>{'id': document.id});
        final data = CourseData.fromMap(documentData);

        if (name == null) {
          return data;
        }

        if (data.name.toLowerCase().contains(name.toLowerCase())) {
          return data;
        }

        return null;
      }).toList()
        ..removeWhere((data) => data == null);

      controller.add(dataList);
    });

    return controller.stream;
  }

  @override
  Observable<List<SubsectionData>> queryExercises({SectionData section}) {
    final controller = BehaviorSubject<List<SubsectionData>>();

    fb
        .firestore()
        .collection('courses')
        .doc(section.parent.id)
        .collection('sections')
        .doc(section.id)
        .collection('exercises')
        .orderBy('order')
        .onSnapshot
        .listen((snapshot) {
      controller.add(snapshot.docs.map<SubsectionData>((document) {
        final data = document.data();
        data['id'] = document.id;
        final res = ExerciseData.fromMap(data: data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  Observable<List<SubsectionData>> queryMaterials({SectionData section}) {
    final controller = BehaviorSubject<List<SubsectionData>>();

    fb
        .firestore()
        .collection('courses')
        .doc(section.parent.id)
        .collection('sections')
        .doc(section.id)
        .collection('materials')
        .orderBy('order')
        .onSnapshot
        .listen((snapshot) {
      controller.add(snapshot.docs.map<SubsectionData>((document) {
        final data = document.data();
        data['id'] = document.id;
        final res = MaterialData.fromMap(data: data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  Observable<List<QuestionData>> queryQuestions({ExerciseData exercise, int size}) {
    // TODO: implement queryQuestions
    return null;
  }

  @override
  Observable<List<SectionData>> querySections({CourseData course}) {
    final controller = BehaviorSubject<List<SectionData>>();

    fb
        .firestore()
        .collection('courses')
        .doc(course.id)
        .collection('sections')
        .orderBy('order')
        .onSnapshot
        .listen((snapshot) {
      controller.add(snapshot.docs.map<SectionData>((document) {
        final data = document.data();
        data['id'] = document.id;
        final res = SectionData.fromMap(data, parent: course);

        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<String>> queryStars({@required CourseData course}) {
    final controller = BehaviorSubject<List<String>>();

    fb.firestore().collection('courses').doc(course.id).collection('stars').onSnapshot.listen((snapshot) {
      controller.add(snapshot.docs.map<String>((document) => document.id).toList());
    });

    return controller.stream;
  }

  @override
  Observable<UserData> queryUser(String uid) {
    final controller = BehaviorSubject<UserData>();

    fb.firestore().collection('users').where('uid', '==', uid).limit(1).onSnapshot.listen((snapshot) {
      if (uid == null) return;

      // no user found check
      if (snapshot.docs.length == 0) {
        controller.add(null);
      } else {
        controller.add(snapshot.docs
            .map<UserData>((document) {
              return UserData.fromMap(document.data());
            })
            .toList()
            .first);
      }
    });

    return controller.stream;
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
  void removeQuestion(QuestionData question) {
    // TODO: implement removeQuestion
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
