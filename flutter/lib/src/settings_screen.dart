import 'package:flashcards_common/common.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/app_data.dart';
import 'package:flashcards_flutter/src/custom_drawer.dart';
import 'package:flashcards_flutter/src/i18n/delegate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => new _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = new GlobalKey<FormState>();

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(FlashcardsStrings.settingsNavigationButton()),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              StreamBuilder<UserData>(
                  stream: AppData.of(context).userBloc.query(AppData.of(context).authBloc.user.uid),
                  builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
                    return DropdownButton(
                      value: snapshot.data?.language,
                      onChanged: (String a) {
                        Map<String, dynamic> userMap = snapshot.data.toMap();
                        userMap['language'] = a;
                        AppData.of(context).userBloc.updateUser(UserData.fromMap(userMap));
                        setState(() {
                          Intl.defaultLocale = a;
                        });
                      },
                      items: new List<DropdownMenuItem<String>>.generate(
                        supportedLocales.length,
                        (int index) {
                          return DropdownMenuItem(
                            value: supportedLocales[index].toString(),
                            child: Text(supportedLocales[index].toString()),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
