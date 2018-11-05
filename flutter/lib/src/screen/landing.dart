import 'dart:async';

import 'package:flashcards_flutter/src/components/button_google.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flashcards_flutter/src/screen/new_user.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/i18n.dart';

class LandingScreen extends StatefulWidget {
  final Widget nextScreen;

  /// Show all content without animations.
  final bool withoutAnimations;

  const LandingScreen({
    @required this.nextScreen,
    this.withoutAnimations = false,
  });

  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

// ignore: mixin_inherits_from_not_object
class _LandingScreenState extends State<LandingScreen> with SingleTickerProviderStateMixin {
  final double fontSize = 55.0;
  AnimationController animation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loginButtonVisible = false;

  bool _isLoading = false;

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
        setState(() {});
      })
      ..forward();

    // Run code after [initState], e.g. with mounted context.
    scheduleMicrotask(() {
      signIn(silently: true);

      if (widget.withoutAnimations) {
        setState(() {
          _loginButtonVisible = true;
        });
      } else {
        Timer(animationDuration, () {
          setState(() {
            _loginButtonVisible = true;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 150.0),
              child: _buildLogo(context),
            ),
            Padding(
              padding: EdgeInsets.only(top: 300.0),
              child: _isLoading ? _buildLoading(context) : _buildButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  void _wrongSignIn(BuildContext context) {
    setState(() {
      _isLoading = false;
    });

    final snackbar = SnackBar(
      content: Text(FlashcardsStrings.loadingError()),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  // TODO: detect new user and go to nextNewUserScreen
  Future<void> signIn({bool silently = false}) async {
    setState(() {
      _isLoading = true;
    });

    final state = StateContainer.of(context);

    try {
      final user = silently ? await state.authenticationBloc.signInSilently() : await state.authenticationBloc.signIn();

      if (user == null) {
        _wrongSignIn(context);

        return;
      }
    } on Exception catch (_) {
      _wrongSignIn(context);

      return;
    }

    final userData = await state.userBloc.query(state.authenticationBloc.user.uid).first;

    setState(() {
      _isLoading = false;
    });

    if (userData == null) {
      //new user
      Navigator.of(context).push(MaterialPageRoute(
        builder: (bc) {
          return NewUserScreen(
            nextScreen: widget.nextScreen,
          );
        },
      ));
    } else {
      if (userData.language != null) {
        Intl.defaultLocale = userData.language;
      }

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (bc) => widget.nextScreen,
        ),
        (_) => false,
      );
    }
  }

  Widget _buildLogo(BuildContext context) {
    return Text(
      FlashcardsStrings.appName().toLowerCase(),
      style: TextStyle(
        fontFamily: 'Lobster',
        fontWeight: FontWeight.normal,
        fontSize: widget.withoutAnimations ? fontSize : Curves.elasticOut.transform(animation.value) * fontSize,
        color: Colors.white,
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }

  Widget _buildButtons(BuildContext context) {
    if (widget.withoutAnimations || _loginButtonVisible) {
      return RawGestureDetector(
        child: GoogleButton(
          signIn: _isLoading ? null : signIn,
          text: FlashcardsStrings.signInButton(),
        ),
      );
    }

    return Container();
  }
}
