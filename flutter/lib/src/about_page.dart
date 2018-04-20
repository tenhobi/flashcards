import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => new _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _verNumber = 'NoVersionFound';

  final TextStyle _text = TextStyle(
    color: Colors.white70,
  );

  final TextStyle _highlight = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  MarkdownStyleSheet _buildMarkdownStyle() {
    return MarkdownStyleSheet(
      a: _highlight,
      p: _text,
      strong: _highlight,
      blockSpacing: 30.0,
    );
  }

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo p) {
      setState(() {
        _verNumber = (p.version == null) ? _verNumber : p.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        title: Text('About flashcards'),
        elevation: 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(75.0),
        children: <Widget>[
          MarkdownBody(
            data: '''Version
__$_verNumber __   
 
Open source project with a goal to develop a multiplatform (i.e. web, android, iOS) flashcards learning app. You can check our code on [GitHub](https://github.com/tenhobi/flashcards).

The project started as a part of a software team project at the [Faculty of Information Technology, CTU in Prague](https://fit.cvut.cz/en).''',
            styleSheet: _buildMarkdownStyle(),
            onTapLink: (link) {
              launch(link);
            },
          ),
          // Place holder to create indentation
          Text('', style: TextStyle(fontSize: 30.0)),
          // This markdown has to be separated as there is different action needed onTap
          MarkdownBody(
              data: 'Application is being developed using open source software: [licences]()',
              styleSheet: _buildMarkdownStyle(),
              onTapLink: (_) {
                showLicensePage(context: context);
              }),
        ],
      ),
    );
  }
}
