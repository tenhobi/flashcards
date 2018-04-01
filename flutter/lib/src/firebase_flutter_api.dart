import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards_logic/src/firebase_api.dart';
import 'package:flashcards_logic/src/course_list_data.dart';

class FirebaseFlutterApi extends FirebaseApi {
  // TODO: consider [type] in results
  @override
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name}) {
    StreamController<List<CourseData>> controller = new StreamController<List<CourseData>>.broadcast();

    Firestore.instance.collection('courses').snapshots.listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<CourseData>((DocumentSnapshot document) {
        // TODO: compute progress
        return new CourseData(document.data['name'], 0.6);
      }).toList());
    });

    return controller.stream;
  }
}
