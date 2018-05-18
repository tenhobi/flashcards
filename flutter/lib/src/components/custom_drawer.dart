import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/screen/about.dart';
import 'package:flashcards_flutter/src/screen/landing.dart';
import 'package:flashcards_flutter/src/screen/main.dart';
import 'package:flashcards_flutter/src/screen/search.dart';
import 'package:flashcards_flutter/src/screen/settings.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(state.authenticationBloc.user.displayName),
            accountEmail: Text(state.authenticationBloc.user.email),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                // TODO: any auto value for rounded image?
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(state.authenticationBloc.user.photoUrl),
              ),
            ),
            margin: EdgeInsets.zero,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: StreamBuilder<UserData>(
              stream: state.userBloc.query(state.authenticationBloc.user.uid),
              builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                if (!snapshot.hasData) return Loading();

                return Text(
                  FlashcardsStrings.score(snapshot.data.score),
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(FlashcardsStrings.homeNavigationButton()),
                  onTap: () {
                    Navigator.of(context).pop(); // close drawer
                    Navigator.of(context).pushNamed(MainScreen.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text(FlashcardsStrings.searchNavigationButton()),
                  onTap: () {
                    Navigator.of(context).pop(); // close drawer
                    Navigator.of(context).pushNamed(SearchScreen.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(FlashcardsStrings.aboutNavigationButton()),
                  onTap: () {
                    Navigator.of(context).pop(); // close drawer
                    Navigator.of(context).pushNamed(AboutScreen.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(FlashcardsStrings.settingsNavigationButton()),
                  onTap: () {
                    Navigator.of(context).pop(); // close drawer
                    Navigator.of(context).pushNamed(SettingsScreen.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text(FlashcardsStrings.reportBugNavigationButton()),
                  onTap: () => launch(FlashcardsStrings.reportUrl()),
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text(FlashcardsStrings.signOutNavigationButton()),
                  onTap: () {
                    state.authenticationBloc.signOut();
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
