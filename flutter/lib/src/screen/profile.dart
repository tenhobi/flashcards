import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ProfileScreen extends StatefulWidget {
  final UserData userData;

  const ProfileScreen({@required this.userData});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Map<String, dynamic> _editedUserMap;

  //todo move somewhere more useful than here
  bool isOwner(UserData u) => StateContainer.of(context).authenticationBloc.user.uid == u.uid;

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
    }
  }

  FloatingActionButton _fab() {
    final state = StateContainer.of(context);
    return isOwner(widget.userData) ?
      FloatingActionButton(
        onPressed: _saveInfo,
        child: Icon(Icons.save),
      ) :
      null;
  }

  //todo should probably be moved somewhere else
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget _generateDebugRow(fieldName) {
    return Container(
      padding: EdgeInsets.only(top:8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text("DEBUG $fieldName", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(_editedUserMap[fieldName].toString(), style: TextStyle(fontSize: 20.0),),
            ),
          )
        ],
      ),
    );
  }

  Widget _generateNonEditableRow(fieldName) {
    return Container(
      padding: EdgeInsets.only(top:8.0),
      child: Row(
        children: <Widget>[
          Text("${capitalize(fieldName)}:", ),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(_editedUserMap[fieldName].toString(), style: TextStyle(fontSize: 20.0),),
          )
        ],
      ),
    );
  }

  Widget _generateEditableRow(fieldName) {
    return TextFormField(
      //todo add localization
      decoration: InputDecoration(labelText: capitalize(fieldName)),
      controller: TextEditingController(text: _editedUserMap[fieldName].toString()),
      validator: (val) => val.isEmpty ? FlashcardsStrings.generalEmpty() : null,
      onSaved: (val) => _editedUserMap[fieldName] = val,
    );
  }

  Widget _generateRow(fieldName) {
    final state = StateContainer.of(context);
    return isOwner(widget.userData) ?
    _generateEditableRow(fieldName) :
    _generateNonEditableRow(fieldName);
  }

  Widget _generateLinkRow(FilledLinkType filledLinkData) {
    return Container(
      padding: EdgeInsets.only(top:8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(filledLinkData.linkType.baseUrl, style: TextStyle(color: Colors.black45),),
          Text(filledLinkData.value, style: TextStyle(fontSize: 20.0),),
        ],
      ),
    );
  }

  List<Widget> _generateLinkRows() {
    return widget.userData.links.map(_generateLinkRow).toList();
  }

  @override
  Widget build(BuildContext context) {
    String link = _editedUserMap['photoUrl'];
    link = link == null || link.isEmpty ? "http://www.drunkmall.com/wp-content/uploads/2016/04/Temoporary-Dickbutt-Tattoo.jpg" : link;
    print(link);
    var preparedRows = [
      Container(
        width: 200,
        height: 200,
        child: CircleAvatar(
          child: ClipRRect(
            // TODO: any auto value for rounded image?
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(link),
          ),
        ),
      ),
      _generateRow('name'),
      _generateRow('bio'),
      _generateNonEditableRow('language'),
      _generateNonEditableRow('score'),
    ];
    preparedRows.addAll(_generateLinkRows());
    preparedRows.addAll([
      _generateDebugRow('uid'),
      _generateDebugRow('links'),
    ]);


    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.lightBlue[200],
      floatingActionButton: _fab(),
      appBar: AppBar(
        title: Text(widget.userData.name),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: preparedRows,
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
