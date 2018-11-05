import 'package:flutter/material.dart';
import 'package:flashcards_common/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const _matchingIcons = {
  LinkType.facebook: FontAwesomeIcons.facebook,
  LinkType.github: FontAwesomeIcons.github,
  LinkType.twitter: FontAwesomeIcons.twitter,
};

class _CustomTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;

  _CustomTile({
    @required this.text,
    @required this.icon,
    @required this.backgroundColor,
    @required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(16.0),
      color: backgroundColor,
      textColor: textColor,
      onPressed: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
          ),
          Text(text),
        ],
      ),
    );
  }
}

class LinkTypeTile extends StatelessWidget {
  final FilledLinkType filledLinkType;

  LinkTypeTile({@required this.filledLinkType});

  @override
  Widget build(BuildContext context) {
    return _CustomTile(
      text: filledLinkType.value,
      icon: _matchingIcons[filledLinkType.linkType],
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      onPressed: () {
        launch(filledLinkType.link());
      },
    );
  }
}

class NewLinkTypeTile extends StatelessWidget {
  final String text;

  NewLinkTypeTile({@required this.text});

  @override
  Widget build(BuildContext context) {
    return _CustomTile(
      text: text,
      icon: Icons.add,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      onPressed: () {}, //todo: add this
    );
  }
}
