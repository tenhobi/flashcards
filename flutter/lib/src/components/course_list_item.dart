import 'package:flashcards_common/data.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
							alignment: Alignment.bottomRight,
	            child: Row(
		            mainAxisAlignment: MainAxisAlignment.center,
		            children: <Widget>[
		              StreamBuilder<List<String>>(
				            initialData: [],
										stream: state.courseListBloc.queryStars(course: data),
				            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
				              if(snapshot.data.contains(state.authenticationBloc.user.uid)) {
					              return GestureDetector(
							            onTap: () => state.courseListBloc.unstar(data, state.authenticationBloc.user.uid),
							            child: Icon(
							              Icons.star,
						                color: Colors.white,
						              )
					              );
					            } else {
						            return GestureDetector(
							            onTap: () => state.courseListBloc.star(data, state.authenticationBloc.user.uid),
							            child: Icon(
								            Icons.star_border,
								            color: Colors.white,
							            )
						            );
					            }
				            },
			            ),
			            Padding(
				            padding: EdgeInsets.only(left: 5.0),
			            ),
			            StreamBuilder<List<String>>(
				            stream: state.courseListBloc.queryStars(course: data),
				            initialData: [],
				            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
					            return Text(
						            '${snapshot.data.length}',
						            style: TextStyle(
							            color: Colors.white
						            )
					            );
				            },
			            )
		            ],
	            ),
            ),
          ],
        ),
      ),
    );
  }
}
