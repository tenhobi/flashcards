import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final Widget nextScreen;

  @override
  State<StatefulWidget> createState() => new _LandingScreenState();

  LandingScreen({@required this.nextScreen});
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin { // ignore: mixin_inherits_from_not_object
  final Duration duration = new Duration(seconds: 10);
  final int animationDuration = 4;
  final double fontSize = 45.0;
  bool mainScreenFlag = false;
  AnimationController animation;

  @override
  void initState() {
    super.initState();
    load();
    animation = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: animationDuration),
      lowerBound: 0.0,
      upperBound: 1.0,
    )
      ..addListener(() {
        this.setState(() {});
      })
      ..forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void load() async {
    await new Future.delayed(duration);
    skip();
  }

  void skip() {
    setState(() {
      mainScreenFlag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mainScreenFlag) {
      return widget.nextScreen;
    }

    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: new GestureDetector(
        onTap: skip,
        child: new Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: new Text(
            'flashcards',
            style: new TextStyle(
              fontFamily: 'Lobster',
              fontWeight: FontWeight.normal,
              fontSize: Curves.elasticOut.transform(animation.value) * fontSize,
              color: Theme.of(context).buttonColor,
            ),
          ),
        ),
      ),
    );
  }
}
