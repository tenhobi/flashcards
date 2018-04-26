import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/components/courses_list.dart';
import 'package:flashcards_flutter/src/components/custom_drawer.dart';
import 'package:flashcards_flutter/src/screen/new_course.dart';

import 'package:flashcards_common/common.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => NewCourseScreen(),
              ),
            );
          },
        ),
        appBar: AppBar(
          title: Text('flashcards'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'all'),
              Tab(text: 'created'),
              Tab(text: 'popular'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoursesList(type: CoursesQueryType.all),
            CoursesList(type: CoursesQueryType.created),
            CoursesList(type: CoursesQueryType.popular),
          ],
        ),
      ),
    );
  }
}
