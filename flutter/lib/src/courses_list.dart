import 'dart:math';

import 'package:flashcards_flutter/src/firebase_flutter_api.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_flutter/src/course_screen.dart';
import 'package:flashcards_flutter/src/course_list_item.dart';
import 'package:flashcards_common/common.dart';

class CoursesList extends StatefulWidget {
  final CoursesQueryType type;

  CoursesList(this.type);

  @override
  State<StatefulWidget> createState() => _CoursesListState();
}

// ignore: mixin_inherits_from_not_object
class _CoursesListState extends State<CoursesList> with SingleTickerProviderStateMixin {
  final CourseListBloc _bloc = CourseListBloc(FirebaseFlutterApi());

  void openCourse(CourseData course) {
    Widget courseScreen = CourseScreen(course: course);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext bc) => courseScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CourseData>>(
      stream: _bloc.query(widget.type),
      builder: (BuildContext context, AsyncSnapshot<List<CourseData>> snapshot) {
        if (!snapshot.hasData) return Text('Loading...');
        return OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            children: snapshot.data.map((CourseData document) {
              return GestureDetector(
                onTap: () => openCourse(document),
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: CourseListItem(
                    name: document.name,
                    // TODO: remove random
                    percentage: document.progress ?? Random().nextDouble(),
                  ),
                ),
              );
            }).toList(),
            padding: EdgeInsets.all(8.0),
          );
        });
      },
    );
  }
}
