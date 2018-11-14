import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_flutter/src/screen/course.dart';
import 'package:flashcards_flutter/src/components/course_list_item.dart';
import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_common/data.dart';
import 'package:meta/meta.dart';

class CoursesList extends StatefulWidget {
  final CoursesQueryType type;
  final String name;

  const CoursesList({@required this.type, this.name});

  @override
  State<StatefulWidget> createState() => _CoursesListState();
}

// ignore: mixin_inherits_from_not_object
class _CoursesListState extends State<CoursesList> with SingleTickerProviderStateMixin {
  void openCourse(CourseData course) {
    Navigator.of(context).push<MaterialPageRoute>(
      MaterialPageRoute(
        builder: (bc) => CourseScreen(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return StreamBuilder<UserData>(
      stream: state.authenticationBloc.signedUser(),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) return Loading();

        return StreamBuilder<List<CourseData>>(
          stream: state.courseListBloc.queryAll(
            widget.type,
            authorUid: userSnapshot.data.uid,
            name: widget.name,
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();

            return GridView.extent(
              shrinkWrap: true,
              maxCrossAxisExtent: 200.0,
              children: snapshot.data.map((document) {
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
