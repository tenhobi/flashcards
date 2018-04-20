import 'package:flashcards_flutter/src/custom_drawer.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(),
      drawer: CustomDrawer(),
    );
  }
}
