import 'package:flashcards_common/i18n.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FlipcardPlayWidget extends StatefulWidget {
  final List<Widget> widgets;

  const FlipcardPlayWidget({@required this.widgets});

  @override
  State<FlipcardPlayWidget> createState() => _FlipcardPlayWidgetState();
}

class _FlipcardPlayWidgetState extends State<FlipcardPlayWidget> {
  int totalCount;
  int shownMin;
  int shownMax;

  @override
  void initState() {
    totalCount = widget.widgets.length;
    shownMin = 0;
    shownMax = totalCount > 4 ? 4 : totalCount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          children: widget.widgets.sublist(shownMin, shownMax),
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text(FlashcardsStrings.previous()),
                onPressed: shownMin == 0
                    ? null
                    : () {
                        setState(() {
                          shownMax -= shownMax - shownMin;
                          shownMin -= 4;
                        });
                      },
                color: Theme.of(context).primaryColor,
                disabledColor: Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                textColor: Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                '$shownMax/$totalCount',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: RaisedButton(
                child: Text(FlashcardsStrings.next()),
                onPressed: shownMax == totalCount
                    ? null
                    : () {
                        setState(() {
                          shownMax += totalCount - shownMax > 4 ? 4 : totalCount - shownMax;
                          shownMin += 4;
                        });
                      },
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
