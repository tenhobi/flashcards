import 'package:flashcards_flutter/src/icons/icons.dart';
import 'package:flutter/material.dart';

Widget googleButton(Function signIn, String text) {
  return RaisedButton.icon(
    onPressed: signIn,
    icon: FlashcardsIcons.Google(),
    label: Text(
      text,
      style: TextStyle(
        color: Color.fromARGB(255, 68, 68, 68),
      ),
    ),
    color: Colors.white,
  );
}
