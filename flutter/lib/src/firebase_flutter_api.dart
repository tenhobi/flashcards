import 'dart:async';

import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcards_common/common.dart';
import 'package:meta/meta.dart';

class FirebaseFlutterApi extends FirebaseApi {
  static final FirebaseFlutterApi _instance = FirebaseFlutterApi._();

  FirebaseFlutterApi._();

  factory FirebaseFlutterApi() => _instance;

  // TODO: consider [type] in results
  @override
  Stream<List<CourseData>> queryCourses({CoursesQueryType type, String name}) {
    StreamController<List<CourseData>> controller = StreamController.broadcast();

    Firestore.instance.collection('courses').orderBy('name').snapshots.listen((QuerySnapshot snapshot) {
      controller.add(snapshot.documents.map<CourseData>((DocumentSnapshot document) {
        var data = document.data;
        data['id'] = document.documentID;
        return CourseData.fromMap(data);
      }).toList());
    });

    return controller.stream;
  }

  @override
  Stream<List<SectionData>> querySections({@required CourseData course}) {
    StreamController<List<SectionData>> controller = StreamController.broadcast();

    Firestore.instance.collection('courses').document(course.id).getCollection("sections").snapshots.listen((QuerySnapshot snapshot) {
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
  Stream<List<SubsectionData>> queryMaterialsAndExercises({@required SectionData section}) {
    StreamController<List<SubsectionData>> controller = StreamController.broadcast();

    Firestore.instance.collection('courses').document(section.parent.id).getCollection('sections').document(section.id).getCollection("materials").snapshots.listen((QuerySnapshot snapshot) {
	    controller.add(snapshot.documents.map<SubsectionData>((DocumentSnapshot document) {
        var data = document.data;
        data['id'] = document.documentID;
        MaterialData res = MaterialData.fromMap(data, parent: section);
        return res;
      }).toList());
    });

//    Firestore.instance.collection('courses').document(section.parent.id).getCollection('sections').document(section.id).getCollection("exercises").snapshots.listen((QuerySnapshot snapshot) {
//      controller.add(snapshot.documents.map<SubsectionData>((DocumentSnapshot document) {
//        var data = document.data;
//        data['id'] = document.documentID;
//        ExerciseData res = ExerciseData.fromMap(data, parent: section);
//        return res;
//      }).toList());
//    });

//    Stream<List<SubsectionData>> res = StreamGroup.merge([c1.stream, c2.stream]);
    return controller.stream;
  }

  @override
  void addCourse(CourseData course) {
    Firestore.instance.collection('courses').add(course.toMap());
  }
}
