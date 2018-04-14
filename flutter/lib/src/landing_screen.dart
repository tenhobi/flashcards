import 'dart:async';

import 'package:flashcards_flutter/src/app_data.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/flashcards_strings.dart';

class LandingScreen extends StatefulWidget {
  final Widget nextScreen;
  final Widget nextNewUserScreen;

  @override
  State<StatefulWidget> createState() => _LandingScreenState();

  LandingScreen({@required this.nextScreen, @required this.nextNewUserScreen});
}

// ignore: mixin_inherits_from_not_object
class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  final double fontSize = 45.0;
  AnimationController animation;

  bool loginButtonVisible = false;

  Duration animationDuration = Duration(seconds: 4);

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: animationDuration,
      lowerBound: 0.0,
      upperBound: 1.0,
    )
      ..addListener(() {
        this.setState(() {});
      })
      ..forward();

    signIn(silently: true);
    showLoginButton();
  }

  void showLoginButton() async {
    await Future.delayed(animationDuration);
    loginButtonVisible = true;
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  // TODO: detect new user and go to nextNewUserScreen
  Future<Null> signIn({bool silently = false}) async {
    var u = silently ? await AppData.of(context).bloc.signInSilently() : await AppData.of(context).bloc.signIn();

    if (u == null) return;

    Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext bc) => widget.nextScreen,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: fontSize,
              margin: EdgeInsets.only(bottom: 150.0),
              child: Text(
                'flashcards',
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.normal,
                  fontSize: Curves.elasticOut.transform(animation.value) * fontSize,
                  color: Theme.of(context).buttonColor,
                ),
              ),
            ),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (loginButtonVisible) {
      return RawGestureDetector(
        child: RaisedButton(
          onPressed: signIn,
          child: Text(FlashcardsStrings.of(context).loginButton()),
        ),
      );
    }

    return Container();
  }
}
