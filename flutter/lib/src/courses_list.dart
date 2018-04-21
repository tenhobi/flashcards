import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_flutter/src/course_screen.dart';
import 'package:flashcards_flutter/src/course_list_item.dart';
import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/api.dart';
import 'package:meta/meta.dart';

class CoursesList extends StatefulWidget {
  final CoursesQueryType type;
  final String name;

  CoursesList({@required this.type, this.name});

  @override
  State<StatefulWidget> createState() => _CoursesListState();
}

// ignore: mixin_inherits_from_not_object
class _CoursesListState extends State<CoursesList> with SingleTickerProviderStateMixin {
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
    return FutureBuilder<FirebaseUser>(
      future: AppData.of(context).authBloc.user,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        return StreamBuilder<List<CourseData>>(
          stream: AppData.of(context).courseBloc.queryAll(
            widget.type,
            authorUid: snapshot.data.uid,
            name: widget.name,
          ),
          builder: (BuildContext context, AsyncSnapshot<List<CourseData>> snapshot) {
            if (!snapshot.hasData) return Text('Loading...');
            return GridView.extent(
              shrinkWrap: true,
              maxCrossAxisExtent: 200.0,
              children: snapshot.data.map((CourseData document) {
                return GestureDetector(
                  onTap: () => openCourse(document),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CourseListItem(
                      data: document,
                    ),
                  ),
                );
              }).toList(),
              padding: EdgeInsets.all(8.0),
            );
          },
        );
      },
    );
  }
}
