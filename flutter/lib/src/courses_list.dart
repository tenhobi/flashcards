import 'package:flutter/material.dart';
import 'package:flashcards_flutter/src/course_list_item.dart';

class CoursesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CoursesListState();
}

// ignore: mixin_inherits_from_not_object
class _CoursesListState extends State<CoursesList> with SingleTickerProviderStateMixin {
  final List<List<dynamic>> names = [
    ['Some very long name of course', 0.9],
    ['Some course name', 0.3],
    ['Some very long name of course', 0.45],
    ['Short name', 0.11],
    ['Some course name', 0.3],
    ['Short name', 0.11],
    ['Some course name', 0.3],
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: set up builder to Firebase? For example https://gitter.im/flutter/flutter?at=5ab82792bb1018b37a248570
    return new GridView.count(
      crossAxisCount: 2,
      children: new List.generate(
        names.length,
        (int index) => new Container(
              margin: new EdgeInsets.all(8.0),
              child: new CourseListItem(
                name: names[index][0],
                percentage: names[index][1],
              ),
            ),
      ),
      padding: new EdgeInsets.all(8.0),
    );
  }
}
