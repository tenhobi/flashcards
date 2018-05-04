import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/screen/landing.dart';
import 'package:flashcards_flutter/src/screen/main.dart';
import 'package:flashcards_flutter/src/screen/search.dart';
import 'package:flashcards_flutter/src/screen/settings.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_flutter/src/screen/about.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(StateContainer.of(context).authenticationBloc?.user?.displayName ?? ''),
            accountEmail: Text(StateContainer.of(context).authenticationBloc?.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                // TODO: any auto value for rounded image?
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(StateContainer.of(context).authenticationBloc?.user?.photoUrl ?? ''),
              ),
            ),
            margin: EdgeInsets.zero,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: StreamBuilder<UserData>(
                stream: StateContainer.of(context).userBloc.query(StateContainer.of(context).authenticationBloc.user.uid),
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
                    StateContainer.of(context).authenticationBloc.signOut();
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
