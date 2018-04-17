import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatelessWidget {
  final TextStyle _text = new TextStyle (
      color: Colors.white70
  );

  final TextStyle _link = new TextStyle (
      fontWeight: FontWeight.bold,
      color: Colors.white
  );

  MarkdownStyleSheet _buildMarkdownStyle() {
    return new MarkdownStyleSheet(
        a: _link,
        p: _text,
        strong: _link
    );
  }

  MarkdownBody _buildMarkdown(String data) {
    return new MarkdownBody(
      data: data,
      styleSheet: _buildMarkdownStyle(),
      onTapLink: (link) {
        launch(link);
      }
    );
  }

 /* static MarkdownStyleSheet _styleSheet = new MarkdownStyleSheet (
      a: _link,
      p: _text,
      strong: _important
  );*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: const Text('About flashcards'),
        elevation: 0.0,
      ),
      body: new ListView (
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          new Text(
            'Version',
            style: _text
          ),
          new Text(
              'TODO VERSION',
              style: _link
          ),
          new Text(''),
          _buildMarkdown(
              'Open source project with a goal to develop a multiplatform '
              '(i.e. web, android, iOS) flashcards learning app. You can check '
              'our code on [GitHub](https://github.com/tenhobi/flashcards).'),
          new Text(''),
          _buildMarkdown(
              'The project started as a part of a software team project at '
              'the [Faculty of Information Technology, CTU in Prague](https://fit.cvut.cz/en).'),
          new Text(''),
          new MarkdownBody(
              data: 'Application is being developed using open source software: [licences]()',
              styleSheet: _buildMarkdownStyle(),
              onTapLink: (_) {
                showLicensePage(context: context);
              }
          ),
        ]
      )
    );
  }
}
