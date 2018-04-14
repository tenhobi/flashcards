import 'package:flashcards_flutter/src/app_data.dart';
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
                // TODO: any auto value for circle image?
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(AppData.of(context).bloc?.user?.photoUrl ?? ''),
              ),
            ),
            margin: EdgeInsets.zero,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Search'),
                  onTap: null,
                ),
                Expanded(child: Container()),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: null,
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: null,
                ),
                ListTile(
                  leading: const Icon(Icons.bug_report),
                  title: const Text('Report bug'),
                  onTap: null,
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text('Sign out'),
                  onTap: () {
                    AppData.of(context).bloc.signOut();
                    Navigator.of(context).popUntil(ModalRoute.withName('/'));
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
