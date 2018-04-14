import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CourseListItem extends StatelessWidget {
  final String name;
  final double percentage;

  CourseListItem({@required this.name, this.percentage = 0.0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  name,
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
                widthFactor: percentage,
                child: Container(
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
