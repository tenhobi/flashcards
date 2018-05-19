import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/comments.dart';
import 'package:flashcards_flutter/src/components/sections_list.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tuple/tuple.dart';

class CourseScreen extends StatefulWidget {
  final CourseData course;

  const CourseScreen({@required this.course});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.course.name),
          actions: <Widget>[
            _buildStarCourse(),
            _buildRemoveCourse(),
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
            Container(
              child: Comments(
                course: widget.course,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarCourse() {
    final state = StateContainer.of(context);

    return StreamBuilder<List<String>>(
      initialData: [],
      stream: state.courseListBloc.queryStars(course: widget.course),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        return IconButton(
          onPressed: () {
            snapshot.data.contains(state.authenticationBloc.user.uid)
                ? state.courseListBloc.unlike.add(Tuple2(widget.course, state.authenticationBloc.user.uid))
                : state.courseListBloc.like.add(Tuple2(widget.course, state.authenticationBloc.user.uid));
          },
          icon: Icon(
            snapshot.data.contains(state.authenticationBloc.user.uid) ? Icons.star : Icons.star_border,
            color: Colors.white,
          ),
          tooltip: snapshot.data.contains(state.authenticationBloc.user.uid)
              ? FlashcardsStrings.unlike()
              : FlashcardsStrings.like(),
        );
      },
    );
  }

  Widget _buildRemoveCourse() {
    final state = StateContainer.of(context);

    // Check if the user is the author.
    if (widget.course.authorUid != state.authenticationBloc.user.uid) {
      return Container();
    }

    return IconButton(
      onPressed: () async {
        final bool permission = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(FlashcardsStrings.removeCourseDialog()),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(FlashcardsStrings.no()),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(FlashcardsStrings.yes()),
                ),
              ],
            );
          },
        );

        if (permission) {
          state.courseListBloc.remove.add(widget.course);
          Navigator.of(context).pop();
        }
      },
      icon: Icon(
        Icons.close,
        color: Colors.white,
      ),
      tooltip: FlashcardsStrings.remove(),
    );
  }
}
