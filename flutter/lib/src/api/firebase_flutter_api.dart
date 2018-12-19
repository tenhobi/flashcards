import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_common/data.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseFlutterApi extends FirebaseApi {
  static final FirebaseFlutterApi _instance = FirebaseFlutterApi._();

  factory FirebaseFlutterApi() => _instance;

  FirebaseFlutterApi._();

  @override
  void addComment({@required CourseData course, @required CommentData comment}) {
    Firestore.instance.collection('courses').document(course.id).collection('comments').add(comment.toMap());
  }

  @override
  void addCourse(CourseData course) {
    Firestore.instance.collection('courses').add(course.toMap());
  }

  @override
  void addUser(UserData user) {
    Firestore.instance.collection('users').add(user.toMap());
  }

  @override
  void addSection(SectionData section) {
    Firestore.instance.collection('courses').document(section.parent.id).collection('sections').add(section.toMap());
  }

  @override
  void addSubsection(SubsectionData subsection) {
    final type = SubsectionData.getTypeToString(subsection);
    Firestore.instance
        .collection('courses')
        .document(subsection.parent.parent.id)
        .collection('sections')
        .document(subsection.parent.id)
        .collection(type)
        .add(subsection.toMap());
  }

  @override
  void addQuestion(QuestionData question) {
    final type = SubsectionData.getTypeToString(question.parent);
    Firestore.instance
        .collection('courses')
        .document(question.parent.parent.parent.id)
        .collection('sections')
        .document(question.parent.parent.id)
        .collection(type)
        .document(question.parent.id)
        .collection('questions')
        .add(question.toMap());
  }

  @override
  void editQuestion(QuestionData question) {
    final type = SubsectionData.getTypeToString(question.parent);
    Firestore.instance
        .collection('courses')
        .document(question.parent.parent.parent.id)
        .collection('sections')
        .document(question.parent.parent.id)
        .collection(type)
        .document(question.parent.id)
        .collection('questions')
        .document(question.id)
        .setData(question.toMap());
  }

  @override
  Future<void> createIfAbsent(UserData user) async {
    final a = await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).limit(1).getDocuments();

    if (a.documents.isEmpty) {
      Firestore.instance.collection('users').add(user.toMap());
    }
  }

  @override
  void editSection(SectionData section) {
    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .setData(section.toMap());
  }

  @override
  void editSubsection(SubsectionData subsection) {
    final type = SubsectionData.getTypeToString(subsection);
    Firestore.instance
        .collection('courses')
        .document(subsection.parent.parent.id)
        .collection('sections')
        .document(subsection.parent.id)
        .collection(type)
        .document(subsection.id)
        .setData(subsection.toMap());
  }

  @override
  void like({@required CourseData course, @required String userUid}) {
    Firestore.instance.collection('courses').document(course.id).collection('stars').document(userUid).setData({});
  }

  @override
  void likeComment({CourseData course, CommentData comment, String authorUid}) {
    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('comments')
        .document(comment.id)
        .collection('stars')
        .document(authorUid)
        .setData({});
  }

  @override
  void unlike({@required CourseData course, @required String userUid}) {
    Firestore.instance.collection('courses').document(course.id).collection('stars').document(userUid).delete();
  }

  @override
  void unlikeComment({CourseData course, CommentData comment, String authorUid}) {
    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('comments')
        .document(comment.id)
        .collection('stars')
        .document(authorUid)
        .delete();
  }

  @override
  Future<void> updateUser(UserData user) async {
    final a = await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).limit(1).getDocuments();
    a.documents.first.reference.updateData(user.toMap());
  }

  @override
  Future removeCourse(CourseData course) async {
    await Firestore.instance.collection('courses').document(course.id).delete();
  }

  @override
  void removeSection(SectionData section) {
    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .delete();
  }

  @override
  void removeSubsection(SubsectionData subsection) {
    final type = SubsectionData.getTypeToString(subsection);
    Firestore.instance
        .collection('courses')
        .document(subsection.parent.parent.id)
        .collection('sections')
        .document(subsection.parent.id)
        .collection(type)
        .document(subsection.id)
        .delete();
  }

  @override
  void removeQuestion(QuestionData question) {
    final type = SubsectionData.getTypeToString(question.parent);
    Firestore.instance
        .collection('courses')
        .document(question.parent.parent.parent.id)
        .collection('sections')
        .document(question.parent.parent.id)
        .collection(type)
        .document(question.parent.id)
        .collection('questions')
        .document(question.id)
        .delete();
  }

  @override
  BehaviorSubject<List<CourseData>> queryCourses({
    String authorUid,
    CoursesQueryType type = CoursesQueryType.all,
    String name,
  }) {
    final controller = BehaviorSubject<List<CourseData>>();

    Query courses = Firestore.instance.collection('courses');

    switch (type) {
      case CoursesQueryType.created:
        courses = courses.where('authorUid', isEqualTo: authorUid).orderBy('name');
        break;
      case CoursesQueryType.popular:
      case CoursesQueryType.all:
      default:
    }

    courses.snapshots().listen((snapshot) {
      final dataList = snapshot.documents.map<CourseData>((document) {
        final documentData = document.data..addAll(<String, dynamic>{'id': document.documentID});
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
  BehaviorSubject<List<CommentData>> queryComments(CourseData course) {
    final controller = BehaviorSubject<List<CommentData>>();

    Firestore.instance.collection('courses').document(course.id).collection('comments').snapshots().listen((snapshot) {
      controller.add(snapshot.documents.map<CommentData>((document) {
        final data = document.data;
        data['id'] = document.documentID;
        return CommentData.fromMap(data);
      }).toList());
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<String>> queryCommentsStars({CourseData course, CommentData comment}) {
    final controller = BehaviorSubject<List<String>>();

    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('comments')
        .document(comment.id)
        .collection('stars')
        .snapshots()
        .listen((snapshot) {
      controller.add(snapshot.documents.map<String>((document) {
        return document.documentID;
      }).toList());
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<SubsectionData>> queryExercises({@required SectionData section}) {
    final controller = BehaviorSubject<List<SubsectionData>>();

    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .collection('exercises')
        .orderBy('order')
        .snapshots()
        .listen((snapshot) {
      controller.add(snapshot.documents.map<SubsectionData>((document) {
        final data = document.data;
        data['id'] = document.documentID;
        final res = ExerciseData.fromMap(data: data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<QuestionData>> queryQuestions({ExerciseData exercise, int size}) {
    final controller = BehaviorSubject<List<QuestionData>>();

    Firestore.instance
        .collection('courses')
        .document(exercise.parent.parent.id)
        .collection('sections')
        .document(exercise.parent.id)
        .collection('exercises')
        .document(exercise.id)
        .collection('questions')
        .snapshots()
        .listen((snapshot) {
      final questions = snapshot.documents.map<QuestionData>((document) {
        final data = document.data..addAll(<String, dynamic>{'id': document.documentID});

        switch (exercise.type) {
          case 'flipcards':
            return FlipcardQuestionData.fromMap(data: data, parent: exercise);
          default:
            print('Register this type of exercise in firebase api');
        }
        return null;
      }).toList()
        ..shuffle(Random.secure());
      controller.add(questions.length > size ? questions.sublist(0, size) : questions);
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<SubsectionData>> queryMaterials({@required SectionData section}) {
    final controller = BehaviorSubject<List<SubsectionData>>();

    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .collection('materials')
        .orderBy('order')
        .snapshots()
        .listen((snapshot) {
      controller.add(snapshot.documents.map<SubsectionData>((document) {
        final data = document.data;
        data['id'] = document.documentID;
        final res = MaterialData.fromMap(data: data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<String>> queryStars({@required CourseData course}) {
    final controller = BehaviorSubject<List<String>>();

    Firestore.instance.collection('courses').document(course.id).collection('stars').snapshots().listen((snapshot) {
      controller.add(snapshot.documents.map<String>((document) => document.documentID).toList());
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<SectionData>> querySections({@required CourseData course}) {
    final controller = BehaviorSubject<List<SectionData>>();

    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('sections')
        .orderBy('order')
        .snapshots()
        .listen((snapshot) {
      controller.add(snapshot.documents.map<SectionData>((document) {
        final data = document.data;
        data['id'] = document.documentID;
        final res = SectionData.fromMap(data, parent: course);

        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<UserData> queryUser(String uid) {
    final controller = BehaviorSubject<UserData>();

    Firestore.instance.collection('users').where('uid', isEqualTo: uid).limit(1).snapshots().listen((snapshot) {
      if (uid == null) return;

      // no user found check
      if (snapshot.documents.length == 0) {
        controller.add(null);
      } else {
        controller.add(snapshot.documents
            .map<UserData>((document) {
              return UserData.fromMap(document.data);
            })
            .toList()
            .first);
      }
    });

    return controller.stream;
  }

  @override
  BehaviorSubject<List<UserData>> queryUsers() {
    final controller = BehaviorSubject<List<UserData>>();

    Firestore.instance.collection('users').snapshots().listen((snapshot) {
      controller.add(snapshot.documents.map<UserData>((document) {
        return UserData.fromMap(document.data);
      }).toList());
    });

    return controller.stream;
  }
}
