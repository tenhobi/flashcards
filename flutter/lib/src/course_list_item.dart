import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CourseListItem extends StatelessWidget {
  final String name;
  final double percentage;

  CourseListItem({@required this.name, this.percentage = 0.0});

  @override
  Widget build(BuildContext context) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(8.0),
      child: new Container(
        color: Theme.of(context).primaryColor,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child: new Center(
                child: new Text(
                  name,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                  ),
                ),
              ),
            ),
            new Container(
              height: 10.0,
              alignment: Alignment.centerLeft,
              child: new FractionallySizedBox(
                widthFactor: percentage,
                child: new Container(
                  color: const Color(0x40000000),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
