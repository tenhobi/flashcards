import 'package:flashcards_common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CourseListItem extends StatelessWidget {
  final CourseData course;

  CourseListItem({@required this.course});

  void starCourse() {
    //todo: implement this
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        course.name ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 10.0,
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: course.progress,
                      child: Container(
                        color: Color(0x40000000),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: 0.0,
                top: 0.0,
                child: Container(
                    padding: EdgeInsets.only(top: 2.0, right: 2.0),
                    child: GestureDetector(
                      onTap: starCourse,
                      child: Row(
                        children: <Widget>[
                          Text(course.stars != null ? course.stars.toString() : "0",
                              style: TextStyle(color: Colors.white)),
                          Icon(Icons.star_border, size: 18.0, color: Colors.white)
                        ],
                      ),
                    ))),
          ],
        ));
  }
}
