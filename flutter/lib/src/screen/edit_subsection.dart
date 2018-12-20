import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/screen/edit_question.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_common/data.dart';

class EditSubsectionScreen extends StatefulWidget {
  const EditSubsectionScreen({@required this.original});

  final SubsectionData original;

  @override
  _EditSubsectionScreenState createState() => _EditSubsectionScreenState();
}

class _EditSubsectionScreenState extends State<EditSubsectionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name;
  int _order;
  String _content;

  @override
  void initState() {
    super.initState();
    setState(() {
      _name = widget.original.name;
      _order = widget.original.order;

      if (widget.original is MaterialData) {
        _content = (widget.original as MaterialData).content;
      }
    });
  }

  void _deleteQuestion(QuestionData q) async {
    final state = StateContainer.of(context);
    final permission = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(FlashcardsStrings.removeQuestionDialog()),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(FlashcardsStrings.no()),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(FlashcardsStrings.yes()),
            ),
          ],
        );
      },
    );

    if (permission == true) {
      state.exerciseBloc.remove.add(q);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            SubsectionData newData;

            if (widget.original is MaterialData) {
              newData = (widget.original as MaterialData).copyWith(name: _name, order: _order, content: _content);
            } else {
              newData = widget.original.copyWith(name: _name, order: _order);
            }

            state.sectionListBloc.editSubsection.add(newData);
            Navigator.of(context).pop();
          }
        },
        child: Icon(Icons.check),
      ),
      appBar: AppBar(
        title: Text(FlashcardsStrings.editSubsectionLabel(_name)),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: FlashcardsStrings.newSubsectionName(),
                      ),
                      initialValue: _name,
                      validator: (val) => val.isEmpty ? FlashcardsStrings.newSubsectionNameEmpty() : null,
                      onSaved: (val) => _name = val,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: FlashcardsStrings.newSubsectionOrder(),
                      ),
                      initialValue: _order.toString(),
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      validator: (val) => val.isEmpty ? FlashcardsStrings.newSubsectionOrderEmpty() : null,
                      onSaved: (val) => _order = int.parse(val),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                    ),
                    _buildExerciseRelated(context),
                    _buildMaterialRelated(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionChild(BuildContext context, QuestionData q) {
    if (q is FlipcardQuestionData) {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              q.answer,
              textAlign: TextAlign.start,
            )
          ],
        ),
        padding: EdgeInsets.all(8),
      );
    } else {
      return Container(
        color: Colors.red,
      );
    }
  }

  Widget _buildQuestion(BuildContext context, QuestionData q) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(q.question),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteQuestion(q);
            },
          ),
        ],
      ),
      children: <Widget>[_buildQuestionChild(context, q)],
    );
  }

  Widget _buildNewQuestionButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditQuestionScreen(
                  data: null,
                  isNew: true,
                  parent: widget.original,
                )));
      },
      color: Theme.of(context).primaryColor,
      textColor: Theme.of(context).primaryTextTheme.button.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add),
          Text(FlashcardsStrings.addQuestionLabel()),
        ],
      ),
    );
  }

  List<Widget> _buildQuestionList(BuildContext context, List<QuestionData> questions) {
    if (questions == null) {
      return [Container()];
    }
    return questions.map((q) {
      return _buildQuestion(context, q);
    }).toList();
  }

  Widget _buildExerciseRelated(BuildContext context) {
    final state = StateContainer.of(context);
    if (widget.original is ExerciseData) {
      return StreamBuilder(
        builder: (context, snapshot) {
          return Column(
            children:
                _buildQuestionList(context, snapshot.data).followedBy([_buildNewQuestionButton(context)]).toList(),
          );
        },
        initialData: null,
        stream: state.exerciseBloc.queryQuestions(widget.original, 10000),
      );
    }
    return Container();
  }

  Widget _buildMaterialRelated(BuildContext context) {
    if (widget.original is MaterialData) {
      return TextFormField(
        maxLines: 7,
        decoration: InputDecoration(
          labelText: FlashcardsStrings.newMaterialContent(),
        ),
        initialValue: _content.toString() ?? '',
        validator: (val) => val.isEmpty ? FlashcardsStrings.newMaterialContentEmpty() : null,
        onSaved: (val) => _content = val,
      );
    }

    return Container();
  }
}
