import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/common.dart';

class NewCourseScreen extends StatefulWidget {
  @override
  _NewCourseScreenState createState() => new _NewCourseScreenState();
}

class _NewCourseScreenState extends State<NewCourseScreen> {
  final formKey = new GlobalKey<FormState>();

  String _name;
  String _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            // Form is saved, perform the login now.

            AppData.of(context).courseBloc.create(
                  CourseData(
                    authorUid: AppData.of(context).authBloc.user.uid,
                    name: _name,
                    description: _description,
                    stars: 0,
                  ),
                );

            Navigator.of(context).pop();
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('New course'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (val) => val.isEmpty ? "Name can't be empty." : null,
                onSaved: (val) => _name = val,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (val) => val.isEmpty ? "Description can't be empty." : null,
                onSaved: (val) => _description = val,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
