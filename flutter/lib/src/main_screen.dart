import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/courses_list.dart';
import 'package:flashcards_flutter/src/custom_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        drawer: new CustomDrawer(),
        appBar: new AppBar(
          title: new Text('flashcards'),
          bottom: new TabBar(
            tabs: [
              new Tab(text: 'active'),
              new Tab(text: 'created'),
              new Tab(text: 'popular'),
            ],
          ),
        ),
        body: new TabBarView(
          children: [
            new StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('courses').snapshots,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return new ListView(
                  children: snapshot.data.documents.map((DocumentSnapshot document) {
                    return new ListTile(
                      title: new Text(document['name'] ?? '<No message retrieved>'),
                    );
                  }).toList(),
                );
              },
            ),
//            new CoursesList(),
            new CoursesList(),
            new CoursesList(),
          ],
        ),
      ),
    );
  }
}
