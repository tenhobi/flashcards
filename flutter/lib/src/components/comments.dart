import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/screen/profile.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Comments extends StatefulWidget {
  final CourseData course;

  const Comments({@required this.course, Key key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController _scrollController = ScrollController();

  String _newComment = '';

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: _buildCommentsList(context),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: FlashcardsStrings.addComment(),
                  ),
                  validator: (val) => val.isEmpty ? FlashcardsStrings.cannotBeEmpty() : null,
                  onSaved: (val) => _newComment = val,
                ),
                StreamBuilder<UserData>(
                  stream: state.authenticationBloc.signedUser(),
                  builder: (context, snapshot) {
                    return IconButton(
                      onPressed: () {
                        final form = formKey.currentState;

                        if (form.validate()) {
                          form
                            ..save()
                            ..reset();

                          _scrollController.animateTo(
                            0.0,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );

                          state.courseListBloc.addComment.add(
                            Tuple2(
                              widget.course,
                              CommentData(
                                authorUid: snapshot.data.uid,
                                content: _newComment,
                              ),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.add),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsList(BuildContext context) {
    final state = StateContainer.of(context);

    return StreamBuilder<List<CommentData>>(
      stream: state.courseListBloc.queryComments(course: widget.course),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            final comment = snapshot.data.reversed.elementAt(index);

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StreamBuilder<UserData>(
                            stream: state.userBloc.query(comment.authorUid),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return Loading();

                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (bc) => ProfileScreen(
                                            userData: snapshot.data,
                                          ),
                                    ),
                                  );
                                },
                                child: Text(
                                  snapshot.data.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                          Text(comment.content),
                        ],
                      ),
                    ),
                    Container(
                      child: StreamBuilder<List<String>>(
                        stream: state.courseListBloc.queryCommentsStars(course: widget.course, comment: comment),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Loading();

                          return StreamBuilder<UserData>(
                            stream: state.authenticationBloc.signedUser(),
                            builder: (context, userSnapshot) {
                              if (!userSnapshot.hasData) return Loading();

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      snapshot.data.contains(userSnapshot.data.uid)
                                          ? state.courseListBloc.unlikeComment
                                              .add(Tuple3(widget.course, comment, userSnapshot.data.uid))
                                          : state.courseListBloc.likeComment
                                              .add(Tuple3(widget.course, comment, userSnapshot.data.uid));
                                    },
                                    icon: Icon(
                                      snapshot.data.contains(userSnapshot.data.uid) ? Icons.star : Icons.star_border,
                                    ),
                                    tooltip: snapshot.data.contains(userSnapshot.data.uid)
                                        ? FlashcardsStrings.unlike()
                                        : FlashcardsStrings.like(),
                                  ),
                                  Text(
                                    '${snapshot.data.length}',
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          controller: _scrollController,
        );
      },
    );
  }
}
