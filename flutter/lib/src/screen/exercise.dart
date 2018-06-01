import 'dart:async';

import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/flipcard_play.dart';
import 'package:flashcards_flutter/src/components/flipcard_item.dart';
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

class _ExerciseScreenState extends State<ExerciseScreen> {
  Widget _playWidget = Container();

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
    final state = StateContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exercise.parent.name + ' - ' + widget.exercise.name,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(FlashcardsStrings.rememberThose(),
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 2.0,
              fontSize: 20.0,
            ),
          ),
        _buildFlipcardsPlayWidget(state.exerciseBloc.queryQuestions(widget.exercise, widget.size)),
      ],
      ),
    );
  }

  Widget _buildFlipcardsPlayWidget(Stream<List<QuestionData>> stream) {
    stream.take(1).listen(
      (List<QuestionData> questions) {
        final List<Widget> widgets = [];
        questions.forEach((question) {
          widgets.add(FlipcardItem(
            data: question,
            key: UniqueKey(),
          ));
        });

        _playWidget = FlipcardPlayWidget(widgets: widgets);
      },
    );

    return _playWidget;
  }

  Widget _buildMultichoice() {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
      ),
    );
  }
}
