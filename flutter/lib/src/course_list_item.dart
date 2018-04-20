import 'package:flashcards_common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CourseListItem extends StatelessWidget {
  CourseListItem({@required this.data});

  final CourseData data;

  void starCourse() {
    //todo: implement this
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: <Widget>[

            Expanded(
              child: Center(
                child: Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                  ),
                  Text(
                    '${data.stars}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
