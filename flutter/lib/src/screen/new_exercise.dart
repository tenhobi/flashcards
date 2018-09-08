import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_common/data.dart';

class NewExerciseScreen extends StatefulWidget {
  const NewExerciseScreen({@required this.parent});

  final SectionData parent;

  @override
  _NewExerciseScreenState createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
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
            state.sectionListBloc.queryExercises(section: widget.parent).first.then((exercises) {
              final data =
                  ExerciseData(id: '', parent: widget.parent, name: _name, type: 'flipcards', order: exercises.length);
              state.sectionListBloc.createSubsection.add(data);
              Navigator.of(context).pop();
            });
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(FlashcardsStrings.addExerciseLabel()),
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
