import 'package:flashcards_common/data.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FlipcardItem extends StatelessWidget {
  final FlipcardQuestionData data;

  const FlipcardItem({@required this.data});

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 150.0,
        height: 150.0,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  data.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  data.answer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
