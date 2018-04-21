import 'package:flashcards_common/api.dart';
import 'package:flashcards_flutter/src/courses_list.dart';
import 'package:flashcards_flutter/src/custom_drawer.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          child: TextFormField(
            autofocus: true,
            onFieldSubmitted: (val) {
              setState(() {
                _name = val;
              });
            },
          ),
        ),
      ),
      body: CoursesList(
        type: CoursesQueryType.all,
        name: _name,
      ),
      drawer: CustomDrawer(),
    );
  }
}
