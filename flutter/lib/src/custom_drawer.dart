import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Column(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: const Text('Honza Bittner'),
            accountEmail: new Text('the@honzabittner.cz'),
            margin: EdgeInsets.zero,
          ),
          new Expanded(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Search'),
                  onTap: null,
                ),
                new Expanded(child: new Container()),
                new ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('About'),
                  onTap: null,
                ),
                new ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: null,
                ),
                new ListTile(
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
