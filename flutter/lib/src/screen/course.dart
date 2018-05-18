import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/sections_list.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CourseScreen extends StatefulWidget {
  final CourseData course;

  const CourseScreen({@required this.course});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.course.name),
          actions: <Widget>[
            new GestureDetector(
              child: new Icon(Icons.close),
              onTap: () async {
                final bool permission = await showDialog(
                  context: context,
                  builder: (BuildContext context) => new AlertDialog(
                        content: new Text(FlashcardsStrings.removeCourseDialog()),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(FlashcardsStrings.no()),
                          ),
                          new FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(FlashcardsStrings.yes()),
                          ),
                        ],
                      ),
                );

                if (permission) {
                  state.courseListBloc.remove.add(widget.course);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: FlashcardsStrings.sectionsTab()),
              Tab(text: FlashcardsStrings.descriptionTab()),
              Tab(text: FlashcardsStrings.commentsTab()),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SectionsList(course: widget.course),
            Container(
              padding: EdgeInsets.all(8.0),
              child: MarkdownBody(data: widget.course.description),
            ),
            Container(), // TODO: comments
          ],
        ),
      ),
    );
  }
}
