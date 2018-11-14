import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/screen/about.dart';
import 'package:flashcards_flutter/src/screen/landing.dart';
import 'package:flashcards_flutter/src/screen/main.dart';
import 'package:flashcards_flutter/src/screen/profile.dart';
import 'package:flashcards_flutter/src/screen/search.dart';
import 'package:flashcards_flutter/src/screen/settings.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    void _redirect(name) {
      Navigator.of(context).pop(); // close drawer
      Navigator.of(context).pushNamed(name);
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () async {
                final user = await state.authenticationBloc.signedUser().first; // TODO move to ProfileScreen
                state.userBloc.query(user.uid).listen((userData) {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (bc) => ProfileScreen(
                            userData: userData,
                          ),
                    ),
                  );
                });
              },
              child: StreamBuilder<UserData>(
                stream: state.authenticationBloc.signedUser(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) return Loading();

                  return Column(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(userSnapshot.data.name),
                        accountEmail: Text(''),
                        currentAccountPicture: CircleAvatar(
                          child: ClipRRect(
                            // TODO: any auto value for rounded image?
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.network(userSnapshot.data.photoUrl),
                          ),
                        ),
                        margin: EdgeInsets.zero,
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                        child: StreamBuilder<UserData>(
                          stream: state.userBloc.query(userSnapshot.data.uid),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return Loading();

                            return Text(
                              FlashcardsStrings.score(snapshot.data.score),
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              )),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text(FlashcardsStrings.homeNavigationButton()),
                  onTap: () {
                    _redirect(MainScreen.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text(FlashcardsStrings.searchNavigationButton()),
                  onTap: () {
                    _redirect(SearchScreen.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(FlashcardsStrings.aboutNavigationButton()),
                  onTap: () {
                    _redirect(AboutScreen.route);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(FlashcardsStrings.settingsNavigationButton()),
                  onTap: () {
                    _redirect(SettingsScreen.route);
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
                    state.authenticationBloc.signOut.add(null);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LandingScreen(
                              nextScreen: MainScreen(),
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
