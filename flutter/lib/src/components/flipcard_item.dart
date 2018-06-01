import 'package:flashcards_common/data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FlipcardItem extends StatefulWidget {
  final FlipcardQuestionData data;
  final GlobalKey<FormState> key;

  // this is not the cleanest solution, but nothing else came to my mind
  // need to remember, what state it was in when state was disposed of
  bool _turnFront = true;

  FlipcardItem({@required this.data, this.key});

  @override
  State<FlipcardItem> createState() => _FlipcardItemState(_turnFront);
}

class _FlipcardItemState extends State<FlipcardItem> {
  bool _turnFront;

  _FlipcardItemState(this._turnFront);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _turnFront = !_turnFront;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: 150.0,
            height: 200.0,
            color: _turnFront ? Theme.of(context).primaryColor : Colors.blue[800],
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      _turnFront ? widget.data.question : widget.data.answer,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget._turnFront = _turnFront;
    super.dispose();
  }
}
