import 'package:flashcards_common/i18n.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/components/courses_list.dart';
import 'package:flashcards_flutter/src/components/custom_drawer.dart';
import 'package:flashcards_flutter/src/screen/new_course.dart';

import 'package:flashcards_common/bloc.dart';

class MainScreen extends StatelessWidget {
  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewCourseScreen(),
              ),
            );
          },
        ),
        appBar: AppBar(
          title: Text(FlashcardsStrings.appName()),
          bottom: TabBar(
            tabs: [
              Tab(text: FlashcardsStrings.allCourses()),
              Tab(text: FlashcardsStrings.createdCourses()),
//              Tab(text: FlashcardsStrings.popularCourses()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoursesList(type: CoursesQueryType.all),
            CoursesList(type: CoursesQueryType.created),
//            CoursesList(type: CoursesQueryType.popular),
          ],
        ),
      ),
    );
  }
}
