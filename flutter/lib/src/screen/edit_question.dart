import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/data.dart';

class EditQuestionScreen extends StatefulWidget {
  const EditQuestionScreen({@required this.data, this.isNew = false, this.parent});

  final QuestionData data;
  final SubsectionData parent;
  final bool isNew;

  @override
  _EditQuestionScreenState createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _question = '';
  String _answer = '';

  @override
  void initState() {
    super.initState();
    if (widget.isNew && widget.parent == null) {
      throw "You must provide parent when isNew is set to true";
    }
    if (widget.isNew) {
      return;
    }
    setState(() {
      _question = widget.data.question;
      if (widget.data is FlipcardQuestionData) {
        _answer = (widget.data as FlipcardQuestionData).answer;
      }
    });
  }

  void sendForm() {
    final state = StateContainer.of(context);
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      QuestionData res = FlipcardQuestionData(
          id: widget.isNew ? '' : widget.data.id, parent: widget.parent, question: _question, answer: _answer);

      if (widget.isNew) {
        state.exerciseBloc.create.add(res);
      } else {
        state.exerciseBloc.edit.add(res);
      }
      Navigator.of(context).pop();
    }
  }

  List<Widget> buildFields(BuildContext context) {
    return [
      TextFormField(
        autofocus: true,
        decoration: InputDecoration(
          labelText: FlashcardsStrings.questionQuestion(),
        ),
        maxLines: 7,
        initialValue: _question,
        onSaved: (val) => _question = val,
        validator: (val) => val.isEmpty ? FlashcardsStrings.questionQuestionEmpty() : null,
      ),
      Divider(
        color: Theme.of(context).primaryColor,
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: FlashcardsStrings.questionAnswer(),
        ),
        maxLines: 7,
        initialValue: _answer,
        onSaved: (val) => _answer = val,
        validator: (val) => val.isEmpty ? FlashcardsStrings.questionAnswerEmpty() : null,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: sendForm,
        child: Icon(Icons.check),
      ),
      appBar: AppBar(
        title: Text(widget.isNew ? FlashcardsStrings.addQuestionLabel() : FlashcardsStrings.editQuestionLabel()),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: buildFields(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
