import 'package:flutter/material.dart';
import 'package:flashcards_logic/flashcards.dart';

// These two imports are used just in main, to set things up
import 'package:flutter_localizations/flutter_localizations.dart';
import 'i18n/FlashcardsDelegate.dart';

// This will be imported everywhere you need localized string
import 'i18n/FlashcardsStrings.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flashcards',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'flashcards'),
      localizationsDelegates: [
        new FlashcardsLocalizationDelegate(),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(FlashcardsStrings.of(context).title()),
      ),
      body: new GestureDetector(
        onTap: _decrementCounter,
        child: new Center(
          child: new Container(
            //alignment: Alignment.bottomRight,
            color: new Color.fromARGB(100, 128, 255, 0),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(flashcardsMotto
                    //'Decrease the number by tapping on the green.',
                    ),
                new Text(
                  'Increase the number by pressing the button',
                ),
                new Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
