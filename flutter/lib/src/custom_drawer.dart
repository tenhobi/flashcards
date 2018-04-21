import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flashcards_flutter/src/landing_screen.dart';
import 'package:flashcards_flutter/src/main_screen.dart';
import 'package:flashcards_flutter/src/search_screen.dart';
import 'package:flashcards_flutter/src/settings_screen.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/about_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: AppData.of(context).authBloc.user,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        return Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(snapshot.data.displayName),
                accountEmail: Text(snapshot.data.email),
                currentAccountPicture: CircleAvatar(
                  child: ClipRRect(
                    // TODO: any auto value for rounded image?
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.network(snapshot.data.photoUrl),
                  ),
                ),
                margin: EdgeInsets.zero,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: StreamBuilder<UserData>(
                    stream: AppData.of(context).userBloc.query(snapshot.data.uid),
                    builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                      return Text(
                        FlashcardsStrings.score(snapshot.data?.score ?? 0),
                        style: TextStyle(color: Colors.white),
                      );
                    }),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(FlashcardsStrings.homeNavigationButton()),
                      onTap: () {
                        Navigator.of(context).pop(); // closes the drawer
                        Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) => MainScreen(),
                              ),
                            );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.search),
                      title: Text(FlashcardsStrings.searchNavigationButton()),
                      onTap: () {
                        Navigator.of(context).pop(); // closes the drawer
                        Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) => SearchScreen(),
                              ),
                            );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text(FlashcardsStrings.aboutNavigationButton()),
                      onTap: () {
                        Navigator.of(context).pop(); // closes the drawer
                        Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext bc) => AboutScreen(),
                              ),
                            );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(FlashcardsStrings.settingsNavigationButton()),
                      onTap: () {
                        Navigator.of(context).pop(); // closes the drawer
                        Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context) => SettingsScreen(),
                              ),
                            );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.bug_report),
                      title: Text(FlashcardsStrings.reportBugNavigationButton()),
                      onTap: () {
                        launch('https://github.com/tenhobi/flashcards/issues/new');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.close),
                      title: Text(FlashcardsStrings.signOutNavigationButton()),
                      onTap: () {
                        AppData.of(context).authBloc.signOut();
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
      },
    );
  }
}
