import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_common/api.dart';
import 'package:flashcards_common/data.dart';
import 'package:meta/meta.dart';

class FirebaseFlutterApi extends FirebaseApi {
  static final FirebaseFlutterApi _instance = FirebaseFlutterApi._();

  factory FirebaseFlutterApi() => _instance;

  FirebaseFlutterApi._();

  @override
  Stream<List<CourseData>> queryCourses({
    String authorUid,
    CoursesQueryType type = CoursesQueryType.all,
    String name,
  }) {
    final StreamController<List<CourseData>> controller = StreamController.broadcast();

    Query courses = Firestore.instance.collection('courses');

    switch (type) {
      case CoursesQueryType.created:
        courses = courses.where('authorUid', isEqualTo: authorUid).orderBy('name');
        break;
      case CoursesQueryType.popular:
      case CoursesQueryType.all:
      default:
    }

    courses.snapshots.listen((QuerySnapshot snapshot) {
      final List<CourseData> dataList = snapshot.documents.map<CourseData>((DocumentSnapshot document) {
        final Map<String, dynamic> documentData = document.data..addAll(<String, dynamic>{'id': document.documentID});
        final CourseData data = CourseData.fromMap(documentData);

        if (name == null) {
          return data;
        }

        if (data.name.toLowerCase().contains(name.toLowerCase())) {
          return data;
        }

        return null;
      }).toList()
        ..removeWhere((CourseData data) => data == null);

      controller.add(dataList);
    });

    return controller.stream;
  }

  @override
  Stream<List<String>> queryStars({@required CourseData course}) {
    final StreamController<List<String>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('stars')
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<String>((DocumentSnapshot document) {
        return document.documentID;
      }).toList());
    });

    return controller.stream;
  }

  @override
  void like({@required CourseData course, @required String userUid}) {
    Firestore.instance.collection('courses').document(course.id).collection('stars').document(userUid).setData({});
  }

  @override
  void unlike({@required CourseData course, @required String userUid}) {
    Firestore.instance.collection('courses').document(course.id).collection('stars').document(userUid).delete();
  }

  @override
  Stream<List<SectionData>> querySections({@required CourseData course}) {
    final StreamController<List<SectionData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('sections')
        .orderBy('order')
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<SectionData>((DocumentSnapshot document) {
        final Map<String, dynamic> data = document.data;
        data['id'] = document.documentID;
        final SectionData res = SectionData.fromMap(data, parent: course);

        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  Stream<List<SubsectionData>> queryMaterials({@required SectionData section}) {
    final StreamController<List<SubsectionData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .collection('materials')
        .orderBy('order')
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<SubsectionData>((DocumentSnapshot document) {
        final Map<String, dynamic> data = document.data;
        data['id'] = document.documentID;
        final MaterialData res = MaterialData.fromMap(data: data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  Stream<List<SubsectionData>> queryExercises({@required SectionData section}) {
    final StreamController<List<SubsectionData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .collection('exercises')
        .orderBy('order')
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<SubsectionData>((DocumentSnapshot document) {
        final Map<String, dynamic> data = document.data;
        data['id'] = document.documentID;
        final ExerciseData res = ExerciseData.fromMap(data: data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  void addUser(UserData user) {
    Firestore.instance.collection('users').add(user.toMap());
  }

  @override
  Stream<UserData> queryUser(String uid) {
    final StreamController<UserData> controller = StreamController.broadcast();

    Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .limit(1)
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents
          .map<UserData>((DocumentSnapshot document) {
            return UserData.fromMap(document.data);
          })
          .toList()
          .first);
    });

    return controller.stream;
  }

  @override
  Stream<List<UserData>> queryUsers() {
    final StreamController<List<UserData>> controller = StreamController.broadcast();

    Firestore.instance.collection('users').snapshots.listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<UserData>((DocumentSnapshot document) {
        return UserData.fromMap(document.data);
      }).toList());
    });

    return controller.stream;
  }

  @override
  Future<Null> updateUser(UserData user) async {
    final QuerySnapshot a =
        await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).limit(1).getDocuments();
    a.documents.first.reference.updateData(user.toMap());
  }

  @override
  Future<Null> createIfAbsent(UserData user) async {
    final QuerySnapshot a =
        await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).limit(1).getDocuments();

    if (a.documents.isEmpty) {
      Firestore.instance.collection('users').add(user.toMap());
    }
  }

  @override
  void addCourse(CourseData course) {
    Firestore.instance.collection('courses').add(course.toMap());
  }

  @override
  Future removeCourse(CourseData course) async {
    await Firestore.instance.collection('courses').document(course.id).delete();
  }

  @override
  void addSection(SectionData section) {
    Firestore.instance.collection('courses').document(section.parent.id).collection('sections').add(section.toMap());
    print(section.toMap());
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
  void editSection(SectionData section) {
    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .setData(section.toMap());
  }

  @override
  void addSubsection(SubsectionData subsection) {
    final String type = SubsectionData.getTypeToString(subsection);
    print(subsection.toMap());
    Firestore.instance
        .collection('courses')
        .document(subsection.parent.parent.id)
        .collection('sections')
        .document(subsection.parent.id)
        .collection(type)
        .add(subsection.toMap());
  }

  @override
  void removeSubsection(SubsectionData subsection) {
    final String type = SubsectionData.getTypeToString(subsection);
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
  void editSubsection(SubsectionData subsection) {
    final String type = SubsectionData.getTypeToString(subsection);
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
  void addComment({@required CourseData course, @required CommentData comment}) {
    Firestore.instance.collection('courses').document(course.id).collection('comments').add(comment.toMap());
  }

  @override
  Stream<List<CommentData>> queryComments(CourseData course) {
    final StreamController<List<CommentData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('comments')
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<CommentData>((DocumentSnapshot document) {
        final Map<String, dynamic> data = document.data;
        data['id'] = document.documentID;
        return CommentData.fromMap(data);
      }).toList());
    });

    return controller.stream;
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
  Stream<List<String>> queryCommentsStars({CourseData course, CommentData comment}) {
    final StreamController<List<String>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection('comments')
        .document(comment.id)
        .collection('stars')
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<String>((DocumentSnapshot document) {
        return document.documentID;
      }).toList());
    });

    return controller.stream;
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
  Stream<List<QuestionData>> queryQuestions({ExerciseData exercise, int size}) {
    final StreamController<List<QuestionData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(exercise.parent.parent.id)
        .collection('sections')
        .document(exercise.parent.id)
        .collection('exercises')
        .document(exercise.id)
        .collection('questions')
        .snapshots
        .listen((QuerySnapshot snapshot) {
      final List<QuestionData> questions = snapshot.documents.map<QuestionData>((DocumentSnapshot document) {
        final Map<String, dynamic> data = document.data;
        data['id'] = document.documentID;
        switch (exercise.type) {
          case 'flipcards':
            return FlipcardQuestionData.fromMap(data: data, parent: exercise);
          default:
            print('Register this type of exercise in firebase api');
        }
      }).toList()..shuffle(Random.secure());
      controller.add(questions.length > size ? questions.sublist(0, size) : questions);
    });

    return controller.stream;
  }
}
