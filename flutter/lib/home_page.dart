import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final double myHeight = 60.0;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: new Column(
        children: <Widget>[
          _buildAppBar(context),
          new Expanded(
            child: _buildContent(context),
          ),
          _buildMenu(context),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, int id) {
    return new GestureDetector(
      onTap: () {
        setState(() {
          active = id;
        });
      },
      child: new Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: new Column(
          children: <Widget>[
            new Container(
              height: 3.0,
              color: active == id ? new Color(0xff2962ff) : Colors.transparent,
            ),
            new Container(
              padding: new EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: new Icon(
                icon,
                color: active == id
                    ? new Color(0xff2962ff)
                    : Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int active = 0;

  Widget _buildMenu(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(child: _buildButton(context, Icons.home, 0)),
          new Expanded(child: _buildButton(context, Icons.search, 1)),
          new Expanded(child: _buildButton(context, Icons.person, 2)),
          new Expanded(child: _buildButton(context, Icons.settings, 3)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text(
          'window $active',
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(0xff2962ff),
            new Color(0xff0039cb),
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: <double>[0.20, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).padding.top + widget.myHeight,
      child: new Center(
        child: new Text(
          'flashcards',
          style: new TextStyle(
            fontFamily: 'Lobster',
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
