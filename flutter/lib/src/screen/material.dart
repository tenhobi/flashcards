import 'package:flashcards_common/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flashcards_common/i18n.dart';

class MaterialScreen extends StatelessWidget {
  final MaterialData data;

  const MaterialScreen({@required this.data, Key key}) : super(key: key);

  final TextStyle _text = const TextStyle(
    color: Colors.black,
  );

  final TextStyle _highlight = const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
        elevation: 0.0,
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        padding: EdgeInsets.all(32.0),
        children: <Widget>[
          MarkdownBody(
            data: data.content != null ? data.content : FlashcardsStrings.noMaterialData(),
            styleSheet: _buildMarkdownStyle(),
            onTapLink: launch,
          ),
        ],
      ),
    );
  }
}
