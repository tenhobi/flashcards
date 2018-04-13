import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/common.dart';
import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flashcards_flutter/src/authentication_flutter_api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

enum _LandingScreenUserState { loading, loadingNewUser, loggedNewUser, loggedKnownUser }

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

  _LandingScreenUserState userState = _LandingScreenUserState.loading;

  Duration animationDuration = Duration(seconds: 4);

  FirebaseUser _user;

  @override
  void initState() {
    AuthenticationBloc<FirebaseUser>(AuthenticationFlutterApi()).signInSilently().then((FirebaseUser u) {
      AppData.of(context).user = u;
    });
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
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (userState) {
      case _LandingScreenUserState.loggedKnownUser:
        return widget.nextScreen;
        break;
      case _LandingScreenUserState.loggedNewUser:
        return widget.nextNewUserScreen;
        break;
      case _LandingScreenUserState.loading:
      default:
        return _buildLoading(context);
    }
  }

  Widget _buildLoading(BuildContext context) {
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
    if (userState == _LandingScreenUserState.loadingNewUser) {
      return RawGestureDetector(
        child: RaisedButton(
          onPressed: () => _signIn().then((FirebaseUser u) => print),
          child: Text('login'),
        ),
      );
    } else {
      return Container();
    }
  }
}
