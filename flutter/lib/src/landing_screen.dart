import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/common.dart';
import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flashcards_flutter/src/components/button_google.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/i18n.dart';

class LandingScreen extends StatefulWidget {
  final Widget nextScreen;
  final Widget nextNewUserScreen;

  /// Show all content without animations.
  final bool withoutAnimations;

  @override
  State<StatefulWidget> createState() => _LandingScreenState();

  LandingScreen({@required this.nextScreen, @required this.nextNewUserScreen, this.withoutAnimations = false});
}

// ignore: mixin_inherits_from_not_object
class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  final double fontSize = 55.0;
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

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 150.0),
              child: Text(
                'flashcards',
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontWeight: FontWeight.normal,
                  fontSize:
                      widget.withoutAnimations ? fontSize : Curves.elasticOut.transform(animation.value) * fontSize,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 300.0),
              child: _buildButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: detect new user and go to nextNewUserScreen
  Future<Null> signIn({bool silently = false}) async {
    FirebaseUser user = silently ? await AppData.of(context).authBloc.signInSilently() : await AppData.of(context).authBloc.signIn();

    if (user == null) return;

    // await AppData.of(context).userBloc.query(user.uid) == null
    if (true) {
      AppData.of(context).userBloc.create(new UserData(uid: user.uid));
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext bc) => widget.nextScreen,
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
//    if (widget.withoutAnimations || loginButtonVisible) {
    if (true) {
      return RawGestureDetector(
        child: GoogleButton(
          signIn: signIn,
          text: FlashcardsStrings.loginButton(),
        ),
      );
    }

    return Container();
  }

  void showLoginButton() async {
    await Future.delayed(animationDuration);
    loginButtonVisible = true;
  }
}
