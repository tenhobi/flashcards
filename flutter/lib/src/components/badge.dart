import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final String message;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  Badge({@required this.message, @required this.borderColor, @required this.backgroundColor, @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 3.0),
        borderRadius: BorderRadius.circular(100.0),
        color: backgroundColor,
      ),
      child: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}
