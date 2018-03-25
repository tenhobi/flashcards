import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CourseListItem extends StatelessWidget {
  final String name;
  final double percentage;

  CourseListItem({@required this.name, this.percentage = 0.0});

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(8.0)),
          color: Theme.of(context).primaryColor,
        ),
        margin: new EdgeInsets.all(8.0),
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
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.vertical(bottom: new Radius.circular(8.0)),
              ),
              height: 10.0,
              alignment: Alignment.centerLeft,
              child: new FractionallySizedBox(
                widthFactor: percentage,
                child: new Container(
                  decoration: new BoxDecoration(
                    color: const Color(0x40000000),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
