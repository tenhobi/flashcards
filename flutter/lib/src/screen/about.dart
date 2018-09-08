import 'package:flashcards_common/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends StatefulWidget {
  static const String route = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _verNumber = FlashcardsStrings.noVersion();

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

    PackageInfo.fromPlatform().then((p) {
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
        title: Text(FlashcardsStrings.aboutNavigationButton()),
        elevation: 0.0,
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        padding: EdgeInsets.all(75.0),
        children: <Widget>[
          MarkdownBody(
            data: FlashcardsStrings.aboutText(_verNumber),
            styleSheet: _buildMarkdownStyle(),
            onTapLink: launch,
          ),
          // Place holder to create indentation
          Text('', style: TextStyle(fontSize: 30.0)),
          // This markdown has to be separated as there is different action needed onTap
          MarkdownBody(
            data: FlashcardsStrings.aboutLicensesText(),
            styleSheet: _buildMarkdownStyle(),
            onTapLink: (_) {
              showLicensePage(context: context);
            },
          ),
        ],
      ),
    );
  }
}
