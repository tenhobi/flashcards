import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/data.dart';

class NewSectionScreen extends StatefulWidget {
  const NewSectionScreen({@required this.parent});

  final CourseData parent;

  @override
  _NewSectionScreenState createState() => _NewSectionScreenState();
}

class _NewSectionScreenState extends State<NewSectionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name;

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            state.sectionListBloc.query(course: widget.parent).first.then((sections) {
              state.sectionListBloc.create.add(SectionData(
                name: _name,
                parent: widget.parent,
                order: sections.length,
              ));
              Navigator.of(context).pop();
            });
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(FlashcardsStrings.newSection()),
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
                  labelText: FlashcardsStrings.newSectionName(),
                ),
                validator: (val) => val.isEmpty ? FlashcardsStrings.newSectionNameEmpty() : null,
                onSaved: (val) => _name = val,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
