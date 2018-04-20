import 'package:flashcards_flutter/src/firebase_flutter_api.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/courses_list.dart';
import 'package:flashcards_flutter/src/custom_drawer.dart';

import 'package:flashcards_common/common.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            GestureDetector(
              child: Icon(Icons.add),
              onTap: () {
                CourseListBloc(FirebaseFlutterApi()).create(CourseData('from app', 0.5, ""));
              },
            ),
          ],
          title: Text('flashcards'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'active'),
              Tab(text: 'created'),
              Tab(text: 'popular'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoursesList(CoursesQueryType.active),
            CoursesList(CoursesQueryType.created),
            CoursesList(CoursesQueryType.popular),
          ],
        ),
      ),
    );
  }
}
