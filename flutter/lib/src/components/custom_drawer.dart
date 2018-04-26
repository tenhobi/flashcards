import 'package:flashcards_common/common.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/inherited/app_data.dart';
import 'package:flashcards_flutter/src/screen/landing.dart';
import 'package:flashcards_flutter/src/screen/main.dart';
import 'package:flashcards_flutter/src/screen/search.dart';
import 'package:flashcards_flutter/src/screen/settings.dart';
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
            accountName: Text(AppData.of(context).authBloc?.user?.displayName ?? ''),
            accountEmail: Text(AppData.of(context).authBloc?.user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              child: ClipRRect(
                // TODO: any auto value for rounded image?
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(AppData.of(context).authBloc?.user?.photoUrl ?? ''),
              ),
            ),
            margin: EdgeInsets.zero,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: StreamBuilder<UserData>(
                stream: AppData.of(context).userBloc.query(AppData.of(context).authBloc.user.uid),
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
  }
}
