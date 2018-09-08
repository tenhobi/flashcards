import 'package:flashcards_common/bloc.dart';
import 'package:flashcards_flutter/src/components/courses_list.dart';
import 'package:flashcards_flutter/src/components/custom_drawer.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String route = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
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
