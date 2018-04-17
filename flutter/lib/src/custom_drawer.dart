import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flashcards_flutter/src/landing_screen.dart';
import 'package:flashcards_flutter/src/main_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(AppData.of(context).bloc?.user?.displayName ?? ''),
            accountEmail: Text(AppData.of(context).bloc?.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                // TODO: any auto value for rounded image?
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(AppData.of(context).bloc?.user?.photoUrl ?? ''),
              ),
            ),
            margin: EdgeInsets.zero,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text('Search'),
                  onTap: null,
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('About'),
                  onTap: null,
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: null,
                ),
                ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text('Report bug'),
                  onTap: null,
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text('Sign out'),
                  onTap: () {
                    AppData.of(context).bloc.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                          new MaterialPageRoute(
                            builder: (BuildContext context) => LandingScreen(
                                  nextScreen: MainScreen(),
                                  nextNewUserScreen: MainScreen(),
                                  withoutAnimations: true,
                                ),
                          ),
                          (_) => false,
                        );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
