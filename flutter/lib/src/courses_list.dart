import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flashcards_flutter/src/course_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoursesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CoursesListState();
}

// ignore: mixin_inherits_from_not_object
class _CoursesListState extends State<CoursesList> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: outsource to API
    return new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('courses').snapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        return new GridView.count(
          crossAxisCount: 2,
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new Container(
              margin: new EdgeInsets.all(8.0),
              child: new CourseListItem(
                name: document['name'],
                percentage: document['progress'] ?? new Random().nextDouble(),
              ),
            );
          }).toList(),
          padding: new EdgeInsets.all(8.0),
        );
      },
    );
  }
}
