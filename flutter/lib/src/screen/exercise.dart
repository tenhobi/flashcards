import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/components/flipcard_item.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

class ExerciseScreen extends StatefulWidget {
  final ExerciseData exercise;
  final int size;

  const ExerciseScreen({@required this.exercise, @required this.size});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    switch (widget.exercise.type) {
      case 'flipcards':
        return _buildFlipcards(context);
      case 'multichoice':
        return _buildMultichoice();
      default:
        break;
    }
  }

  Widget _buildFlipcards(BuildContext context) {
    final state = StateContainer.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise.name),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Remember those',
              textAlign: TextAlign.center,
            ),
            StreamBuilder<List<QuestionData>>(
              stream: state.exerciseBloc.queryQuestions(widget.exercise, widget.size),
              builder: (BuildContext context, AsyncSnapshot<List<QuestionData>> snapshot) {
                if (!snapshot.hasData) return Loading();

                /* TODO: rotating cards with question and answer on other side, only 4 per screen, button
                   next to switch to next page and stuff, next code is just placeholder so it compiles
                */
                return GridView.extent(
                  shrinkWrap: true,
                  maxCrossAxisExtent: 200.0,
                  children: snapshot.data.map((QuestionData question) {
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FlipcardItem(
                          data: question,
                        ),
                      ),
                    );
                  }).toList(),
                  padding: EdgeInsets.all(8.0),
                );
              },
            ),
          ],
        ));
  }

  Widget _buildMultichoice() {
    return Scaffold(
      appBar: AppBar(
        title: Text("multi"),
      ),
    );
  }
}
