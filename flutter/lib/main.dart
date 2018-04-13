import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/landing_screen.dart';
import 'package:flashcards_flutter/src/main_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppData(
      i: 5,
      child: new MaterialApp(
        title: 'Flashcards',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingScreen(nextScreen: MainScreen()),
      ),
    );
  }
}
