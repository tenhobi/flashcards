import 'package:flashcards_flutter/src/custom_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new CustomDrawer(),
      appBar: new AppBar(
        title: new Text('flashcards'),
      ),
      body: new Center(
        child: new Text('my main app screen'),
      ),
    );
  }
}
