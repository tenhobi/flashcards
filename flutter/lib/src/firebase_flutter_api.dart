import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards_common/common.dart';

class FirebaseFlutterApi extends FirebaseApi {
  static final FirebaseFlutterApi _instance = new FirebaseFlutterApi._();

  FirebaseFlutterApi._();

  factory FirebaseFlutterApi() => _instance;

  // TODO: consider [type] in results
  @override
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name}) {
    StreamController<List<CourseData>> controller = new StreamController<List<CourseData>>.broadcast();

    Firestore.instance.collection('courses').orderBy('name').snapshots.listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<CourseData>((DocumentSnapshot document) {
        return new CourseData.fromMap(document.data);
      }).toList());
    });

    return controller.stream;
  }

  @override
  void addCourse(CourseData course) {
    Firestore.instance.collection('courses').add(course.toMap());
  }
}
