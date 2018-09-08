import 'package:flutter/material.dart';
import 'package:flashcards_common/i18n.dart';

class ExerciseSize extends StatefulWidget {
  @override
  _ExerciseSizeState createState() => _ExerciseSizeState();
}

class _ExerciseSizeState extends State<ExerciseSize> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _questionCount;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(FlashcardsStrings.numberOfQuestions()),
      content: Form(
        key: formKey,
        child: TextFormField(
          autofocus: true,
          initialValue: '20',
          decoration: InputDecoration(
            labelText: FlashcardsStrings.numberOfQuestions(),
          ),
          keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
          validator: (val) {
            if (val.isEmpty) {
              return FlashcardsStrings.cannotBeEmpty();
            }

            final value = int.parse(val);
            // magic number - choose how big can the exercise be, 50 seems fair
            if (value > 50 || value == 0) {
              return FlashcardsStrings.wrongInput();
            }
            return null;
          },
          onSaved: (val) => _questionCount = int.parse(val),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(FlashcardsStrings.cancel()),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
        FlatButton(
          child: Text(FlashcardsStrings.submit()),
          onPressed: () {
            final dialog = formKey.currentState;

            if (dialog.validate()) {
              dialog.save();
              Navigator.pop(context, _questionCount);
            }
          },
        ),
      ],
    );
  }
}
