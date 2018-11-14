import 'package:flashcards_common/data.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/components/custom_drawer.dart';
import 'package:flashcards_flutter/src/components/indicator_loading.dart';
import 'package:flashcards_flutter/src/i18n/delegate.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  static const String route = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    final GlobalKey formKey = GlobalKey<FormState>();

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
                stream: state.authenticationBloc.signedUser(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) return Loading();

                  return StreamBuilder<UserData>(
                    stream: state.userBloc.query(userSnapshot.data.uid),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Loading();

                      return DropdownButton(
                        value: snapshot.data?.language,
                        onChanged: (a) {
                          final userMap = snapshot.data.toMap();
                          userMap['language'] = a;
                          state.userBloc.update.add(UserData.fromMap(userMap));
                          setState(() {
                            Intl.defaultLocale = a;
                          });
                        },
                        items: List<DropdownMenuItem<String>>.generate(
                          supportedLocales.length,
                          (index) {
                            return DropdownMenuItem(
                              value: supportedLocales[index].toString(),
                              child: Text(supportedLocales[index].toString()),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
