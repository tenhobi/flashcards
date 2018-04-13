import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Honza Bittner'),
            accountEmail: Text('the@honzabittner.cz'),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
