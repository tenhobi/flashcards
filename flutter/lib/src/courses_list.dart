import 'dart:math';

import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flashcards_flutter/src/firebase_flutter_api.dart';
import 'package:flutter/material.dart';
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
//  final CourseListBloc _bloc = CourseListBloc(FirebaseFlutterApi());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CourseData>>(
      stream: AppData.of(context).courseBloc.queryAll(widget.type, authorUid: AppData.of(context).authBloc.user.uid),
      builder: (BuildContext context, AsyncSnapshot<List<CourseData>> snapshot) {
        if (!snapshot.hasData) return Text('Loading...');
        return GridView.extent(
          maxCrossAxisExtent: 200.0,
          children: snapshot.data.map((CourseData document) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: CourseListItem(
                data: document,
              ),
            );
          }).toList(),
          padding: EdgeInsets.all(8.0),
        );
      },
    );
  }
}
