import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/data.dart';

class NewUserScreen extends StatefulWidget {
  final Widget nextScreen;

  const NewUserScreen({
    @required this.nextScreen,
  });

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _bio;
  final List<FilledLinkType> _links = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _generateLinkInput(linkType) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        autocorrect: false,
        decoration: InputDecoration(
          labelText: linkType.baseUrl,
        ),
        onSaved: (value) {
          if (value == null || value.isEmpty) {
            return;
          }
          final tuple = FilledLinkType(linkType: linkType, value: value);

          if (_links.length > 0) {
            final index = _links.indexOf(tuple);
            if (index != -1) {
              _links.removeAt(index);
            }
          }

          _links.add(tuple);
        },
      ),
    );
  }

  List<Widget> _generateLinks() {
    return LinkType.values.map(_generateLinkInput).toList();
  }

  Widget _generateBiographyInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: FlashcardsStrings.bioPlaceholder(),
      ),
      keyboardType: TextInputType.text,
      autocorrect: false,
      onSaved: (value) {
        _bio = value;
      },
      //Not required i guess
//      validator: (value) {
//        if (value.isEmpty || value.length < 1) {
//          return FlashcardsStrings.bioEmpty();
//        }
//      },
    );
  }

  Widget _generateSubmitButton() {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: RaisedButton(
        onPressed: _submitForm,
        child: Text(
          FlashcardsStrings.submitDetails(),
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
      ),
    );
  }

  List<Widget> _prepareChildren() {
    var res = <Widget>[];
    res.add(_generateBiographyInput());
    res.addAll(_generateLinks());
    res.add(_generateSubmitButton());
    return res;
  }

  Future _submitForm() async {
    final state = StateContainer.of(context);
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      final user = await state.authenticationBloc.signedUser().first;

      final userData = UserData(
        uid: user.uid,
        name: user.name,
        bio: _bio,
        links: _links,
        photoUrl: user.photoUrl,
      );

      state.userBloc.create.add(userData);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (bc) => widget.nextScreen,
        ),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlashcardsStrings.newUser()),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(children: _prepareChildren()),
        ),
      ),
    );
  }
}
