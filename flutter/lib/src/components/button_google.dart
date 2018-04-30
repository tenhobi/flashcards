import 'package:flashcards_flutter/src/icons/icons.dart';
import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final Function signIn;

  final String text;

  const GoogleButton({Key key, this.signIn, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: signIn,
      icon: FlashcardsIcons.google(),
      label: Text(
        text,
        style: TextStyle(
          color: Color.fromARGB(255, 68, 68, 68),
        ),
      ),
      color: Colors.white,
    );
  }
}
