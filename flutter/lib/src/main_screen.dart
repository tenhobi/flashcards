import 'dart:async';

import 'package:flashcards_flutter/src/firebase_flutter_api.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/courses_list.dart';
import 'package:flashcards_flutter/src/custom_drawer.dart';

import 'package:flashcards_common/common.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);

    print('user name: ${user.displayName}');
    print(user);
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print('User signed out.');
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        drawer: new CustomDrawer(),
        appBar: new AppBar(
          actions: <Widget>[
            new GestureDetector(
              child: new Icon(Icons.add),
              onTap: () {
                new CourseListBloc(new FirebaseFlutterApi()).create(new CourseData('from app', 0.5));
              },
            ),
          ],
          title: new Text('flashcards'),
          bottom: new TabBar(
            tabs: [
              new Tab(text: 'active'),
              new Tab(text: 'created'),
              new Tab(text: 'popular'),
            ],
          ),
        ),
        body: new TabBarView(
          children: [
            new Container(
              child: new ListView(
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () => _signIn().catchError((e) => print(e)),
                    child: new Text('Sign in'),
                    color: Colors.green,
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                    onPressed: _signOut,
                    child: new Text('Sign out'),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
//            new CoursesList(CoursesQueryType.active),
            new CoursesList(CoursesQueryType.created),
            new CoursesList(CoursesQueryType.popular),
          ],
        ),
      ),
    );
  }
}
