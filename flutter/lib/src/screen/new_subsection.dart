import 'dart:async';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/data.dart';

class NewSubsectionScreen extends StatefulWidget {
  const NewSubsectionScreen({@required SectionData this.parent});
  final SectionData parent;
  @override
  _NewSubsectionScreenState createState() => new _NewSubsectionScreenState();
}

class _NewSubsectionScreenState extends State<NewSubsectionScreen> {
  final formKey = new GlobalKey<FormState>();

  String _name;

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            Stream<List<SubsectionData>> query;
            if (widget.parent is ExerciseData) {
              query = state.sectionListBloc.queryExercises(section: widget.parent);
            } else {
              query = state.sectionListBloc.queryMaterials(section: widget.parent);
            }
            query.first.then((List<SubsectionData> subsections) {
              SubsectionData data;
              if (widget.parent is ExerciseData) {
                data = ExerciseData(id: '', parent: widget.parent, name: _name, type: 'flipcards', order: subsections.length); // TODO: different types of exercises
              } else {
                data = MaterialData(id: '', parent: widget.parent, name: _name, order: subsections.length);
              }
              state.sectionListBloc.createSubsection.add(data);
              Navigator.of(context).pop();
            });
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(widget.parent is ExerciseData
            ? FlashcardsStrings.addExerciseLabel()
            : FlashcardsStrings.addMaterialLabel()),
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
