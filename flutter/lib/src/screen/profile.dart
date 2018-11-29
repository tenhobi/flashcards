import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flashcards_flutter/src/components/badge.dart';
import 'package:flashcards_flutter/src/components/link_type_tile.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ProfileScreen extends StatefulWidget {
  final UserData userData;

  const ProfileScreen({@required this.userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

const MaterialColor headerColor = Colors.blue;

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> _editedUserMap;
  bool _edditing = false;

  //todo should probably be moved somewhere else
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  void initState() {
    super.initState();
    _editedUserMap = widget.userData.toMap();
  }

  void _saveInfo() {
    final state = StateContainer.of(context);
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();

      final userData = UserData.fromMap(_editedUserMap);

      state.userBloc.update.add(userData);

      final snackbar = SnackBar(
        content: Text(FlashcardsStrings.savedUserData()),
      );

      _scaffoldKey.currentState.showSnackBar(snackbar);

      setState(() {
        _edditing = false;
      });
    }
  }

  FloatingActionButton _fab(UserData signedUser) {
    return (signedUser.uid == widget.userData.uid) && _edditing
        ? FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: _saveInfo,
            child: Icon(Icons.check),
          )
        : null;
  }

  Widget _buildEditableHeaderRow({
    @required double fontSize,
    @required String hintText,
    @required String value,
    @required onSaved,
    @required String Function(String) validator,
    int maxLines = 1,
    bool autocorrect = false,
  }) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
    );
    final border = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    );
    return Theme(
      data: ThemeData(
        cursorColor: Colors.white,
        textSelectionColor: Colors.white,
      ),
      child: Container(
        child: _edditing
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: TextEditingController(text: value),
                  style: textStyle,
                  maxLines: maxLines,
                  autocorrect: autocorrect,
                  onSaved: onSaved,
                  validator: validator,
                  decoration: InputDecoration(
                    hintStyle: textStyle,
                    hintText: hintText,
                    contentPadding: EdgeInsets.all(0.0),
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              )
            : Text(
                value,
                style: textStyle,
              ),
      ),
    );
  }

  Widget _buildImage() {
    String link = _editedUserMap['photoUrl'];
    link = link == null || link.isEmpty
        ? 'http://www.drunkmall.com/wp-content/uploads/2016/04/Temoporary-Dickbutt-Tattoo.jpg'
        : link;

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(color: Colors.blue.shade600, width: 5.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.network(link),
        ),
      ),
    );
  }

  Widget _buildBio() {
    return _buildEditableHeaderRow(
      fontSize: 16.0,
      hintText: FlashcardsStrings.bioName(),
      value: _editedUserMap['bio'],
      autocorrect: true,
      maxLines: 3,
      validator: (val) => null,
      onSaved: (val) {
        _editedUserMap['bio'] = val;
      },
    );
  }

  Widget _buildName() {
    return _buildEditableHeaderRow(
      fontSize: 28.0,
      hintText: FlashcardsStrings.nameName(),
      value: _editedUserMap['name'],
      autocorrect: false,
      maxLines: 1,
      validator: (val) => val.isEmpty ? FlashcardsStrings.nameEmpty() : null,
      onSaved: (val) {
        _editedUserMap['name'] = val;
      },
    );
  }

  Widget _buildLanguage() {
    return Expanded(
      child: Stack(
        overflow: Overflow.clip,
        fit: StackFit.loose,
        children: <Widget>[
          Positioned(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                _editedUserMap['language'],
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            right: 0.0,
            bottom: 0.0,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 240.0,
      decoration: BoxDecoration(
        color: headerColor,
        image: DecorationImage(
            image: NetworkImage(
                "https://images.vexels.com/media/users/3/145867/isolated/preview/015b2a1aac5e9d4d3c18376bbbae1819-sound-wave-line-by-vexels.png"),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            colorFilter: ColorFilter.mode(headerColor.withOpacity(0.9), BlendMode.srcOver)),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                overflow: Overflow.visible,
                fit: StackFit.loose,
                children: <Widget>[
                  Positioned(
                    child: _buildImage(),
                  ),
                  Positioned(
                    bottom: -10.0,
                    right: 6.0,
                    child: Badge(
                      message: _editedUserMap['score'].toString(),
                      backgroundColor: Colors.white,
                      borderColor: Colors.blue.shade600,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.only(top: 12.0),
            ),
            _buildName(),
            _buildBio(),
            _buildLanguage(),
          ],
        ),
      ),
    );
  }

  void _clearEditedData() {
    setState(() {
      _edditing = false;
      _editedUserMap = widget.userData.toMap();
    });
  }

  List<Widget> _buildTiles() {
    var res = <Widget>[];
    res.addAll(widget.userData.links
        .map((filledLinkType) => LinkTypeTile(
              filledLinkType: filledLinkType,
            ))
        .toList());

    if (res.length < LinkType.values.length) {
      res.add(NewLinkTypeTile(text: FlashcardsStrings.newLink()));
    }
    return res;
  }

  List<Widget> _buildActions() {
    return [
      _edditing
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: _clearEditedData,
            )
          : IconButton(
              icon: Icon(Icons.mode_edit),
              onPressed: () {
                setState(() {
                  _edditing = true;
                });
              },
            )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    return StreamBuilder<UserData>(
      stream: state.authenticationBloc.signedUser(),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) return Loading();

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          floatingActionButton: _fab(userSnapshot.data),
          appBar: AppBar(
            title: Text(FlashcardsStrings.profileScreenTitle()),
            backgroundColor: headerColor,
            elevation: 0.0,
            actions: _buildActions(),
          ),
          body: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildHeader(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      //todo: redesign social media grid
                      child: GridView.count(
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        crossAxisCount: 3,
                        children: _buildTiles(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
