import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/flipcard_item.dart';
import 'package:flashcards_flutter/src/components/flipcard_play.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ExerciseScreen extends StatefulWidget {
  final ExerciseData exercise;
  final int size;

  const ExerciseScreen({
    @required this.exercise,
    @required this.size,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> with AfterLayoutMixin<ExerciseScreen> {
  Widget _playWidget = Container();

  @override
  Future afterFirstLayout(BuildContext context) async {
    final state = StateContainer.of(context);
    final data = await state.exerciseBloc.queryQuestions(widget.exercise, widget.size).first;
    final widgets = List<Widget>.from(data.map((question) => FlipcardItem(data: question, key: UniqueKey())));

    setState(() {
      _playWidget = FlipcardPlayWidget(widgets: widgets);
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.exercise.type) {
      case 'flipcards':
        return _buildFlipcards(context);
      case 'multichoice':
        return _buildMultichoice();
      default:
        return Container();
    }
  }

  Widget _buildFlipcards(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.exercise.parent.name} - ${widget.exercise.name}',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            FlashcardsStrings.rememberThose(),
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 2.0,
              fontSize: 20.0,
            ),
          ),
          _playWidget,
        ],
      ),
    );
  }

  Widget _buildMultichoice() {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
    );
  }
}
