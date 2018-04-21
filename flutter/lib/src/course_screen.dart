import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/sections_list.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CourseScreen extends StatefulWidget {
  final CourseData course;

  CourseScreen({@required this.course});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text(widget.course.name),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: FlashcardsStrings.sectionsTab()),
                Tab(text: FlashcardsStrings.descriptionTab()),
              ],
            )),
        body: TabBarView(
          children: <Widget>[
            SectionsList(course: widget.course),
            Container(
              padding: EdgeInsets.all(8.0),
              child: MarkdownBody(data: widget.course.description),
            )
          ],
        ),
      ),
    );
  }
}
