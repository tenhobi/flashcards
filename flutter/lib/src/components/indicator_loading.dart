import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    Widget textWidget;

    if (text == '') {
      textWidget = Container(
        width: 0.0,
        height: 0.0,
      );
    } else {
      textWidget = Container(
        child: Text(text),
        padding: EdgeInsets.only(top: 12.0),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[CircularProgressIndicator(), textWidget],
    );
  }
}
