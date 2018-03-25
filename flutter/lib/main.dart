import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/landing_screen.dart';
import 'package:flashcards_flutter/src/main_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flashcards',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LandingScreen(nextScreen: new MainScreen()),
    );
  }
}
