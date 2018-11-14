import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

class CourseListItem extends StatelessWidget {
  final CourseData data;

  const CourseListItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    data.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: StreamBuilder<List<String>>(
                stream: state.courseListBloc.queryStars(course: data),
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
                                  ? state.courseListBloc.unlike.add(Tuple2(data, userSnapshot.data.uid))
                                  : state.courseListBloc.like.add(Tuple2(data, userSnapshot.data.uid));
                            },
                            icon: Icon(
                              snapshot.data.contains(userSnapshot.data.uid) ? Icons.star : Icons.star_border,
                              color: Colors.white,
                            ),
                            tooltip: snapshot.data.contains(userSnapshot.data.uid)
                                ? FlashcardsStrings.unlike()
                                : FlashcardsStrings.like(),
                          ),
                          Text(
                            '${snapshot.data.length}',
                            style: TextStyle(color: Colors.white),
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
  }
}
