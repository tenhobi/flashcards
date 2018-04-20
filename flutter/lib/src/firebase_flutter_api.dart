import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards_common/common.dart';
import 'package:meta/meta.dart';
import 'package:flashcards_common/src/data/user.dart';

class FirebaseFlutterApi extends FirebaseApi {
  static final FirebaseFlutterApi _instance = FirebaseFlutterApi._();

  FirebaseFlutterApi._();

  factory FirebaseFlutterApi() => _instance;

  @override
  Stream<List<CourseData>> queryCourses({
    String authorUid,
    CoursesQueryType type = CoursesQueryType.all,
    String name,
  }) {
    StreamController<List<CourseData>> controller = StreamController.broadcast();

    Query courses = Firestore.instance.collection('courses');

    switch (type) {
      case CoursesQueryType.created:
        courses = courses.where('authorUid', isEqualTo: authorUid).orderBy('name');
        break;
      case CoursesQueryType.popular:
        courses = courses.orderBy('stars', descending: true);
        break;
      case CoursesQueryType.all:
      default:
    }

    courses.snapshots.listen((QuerySnapshot snapshot) {
      List<CourseData> dataList = snapshot.documents.map<CourseData>((DocumentSnapshot document) {
        Map<String, dynamic> documentData = document.data;
        documentData.addAll({'id': document.documentID});
        CourseData data = CourseData.fromMap(documentData);

        if (name == null) {
          return data;
        }

        if (data.name.toLowerCase().contains(name.toLowerCase())) {
          return data;
        }

        return null;
      }).toList();

      dataList.removeWhere((CourseData data) => data == null);

      controller.add(dataList);
    });

    return controller.stream;
  }

  @override
  Stream<List<SectionData>> querySections({@required CourseData course}) {
    StreamController<List<SectionData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(course.id)
        .collection("sections")
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<SectionData>((DocumentSnapshot document) {
        var data = document.data;
        data['id'] = document.documentID;
        SectionData res = SectionData.fromMap(data, parent: course);

        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  Stream<List<SubsectionData>> queryMaterials({@required SectionData section}) {
    StreamController<List<SubsectionData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .collection("materials")
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<SubsectionData>((DocumentSnapshot document) {
        var data = document.data;
        data['id'] = document.documentID;
        MaterialData res = MaterialData.fromMap(data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
  }

  @override
  Stream<List<SubsectionData>> queryExercises({@required SectionData section}) {
    StreamController<List<SubsectionData>> controller = StreamController.broadcast();

    Firestore.instance
        .collection('courses')
        .document(section.parent.id)
        .collection('sections')
        .document(section.id)
        .collection("exercises")
        .snapshots
        .listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<SubsectionData>((DocumentSnapshot document) {
        var data = document.data;
        data['id'] = document.documentID;
        ExerciseData res = ExerciseData.fromMap(data, parent: section);
        return res;
      }).toList());
    });

    return controller.stream;
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
  Stream<UserData> queryUser(String uid) {
    StreamController<UserData> controller = StreamController.broadcast();

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
    StreamController<List<UserData>> controller = StreamController.broadcast();

    Firestore.instance.collection('users').snapshots.listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<UserData>((DocumentSnapshot document) {
        return UserData.fromMap(document.data);
      }).toList());
    });

    return controller.stream;
  }

  @override
  Future<Null> updateUser(UserData user) async {
    QuerySnapshot a = await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).limit(1).getDocuments();
    a.documents.first.reference.updateData(user.toMap());
  }

  @override
  Future<Null> createIfAbsent(UserData user) async {
    QuerySnapshot a = await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).limit(1).getDocuments();

    if (a.documents.length == 0) {
      Firestore.instance.collection('users').add(user.toMap());
    }
  }
}
