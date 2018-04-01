import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/courses_list.dart';
import 'package:flashcards_flutter/src/custom_drawer.dart';

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
            new CoursesList(CoursesQueryType.active),
            new CoursesList(CoursesQueryType.created),
            new CoursesList(CoursesQueryType.popular),
          ],
        ),
      ),
    );
  }
}
