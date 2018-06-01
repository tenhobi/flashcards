import 'package:flashcards_common/data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FlipcardItem extends StatefulWidget {
  final FlipcardQuestionData data;

  const FlipcardItem({
    @required this.data,
    Key key,
  }) : super(key: key);

  @override
  State<FlipcardItem> createState() => _FlipcardItemState();
}

class _FlipcardItemState extends State<FlipcardItem> {
  bool _turnFront = true;

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
}
