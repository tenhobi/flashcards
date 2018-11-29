import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_common/data.dart';

class NewMaterialScreen extends StatefulWidget {
  const NewMaterialScreen({@required this.parent});

  final SectionData parent;

  @override
  _NewMaterialScreenState createState() => _NewMaterialScreenState();
}

class _NewMaterialScreenState extends State<NewMaterialScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name;
  String _content;

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            state.sectionListBloc.queryMaterials(section: widget.parent).first.then((materials) {
              final data =
                  MaterialData(id: '', parent: widget.parent, name: _name, order: materials.length, content: _content);
              state.sectionListBloc.createSubsection.add(data);
              Navigator.of(context).pop();
            });
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(FlashcardsStrings.addMaterialLabel()),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: FlashcardsStrings.newMaterialName(),
                      ),
                      validator: (val) => val.isEmpty ? FlashcardsStrings.newMaterialNameEmpty() : null,
                      onSaved: (val) => _name = val,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: FlashcardsStrings.newMaterialContent(),
                      ),
                      maxLines: 10,
                      validator: (val) => val.isEmpty ? FlashcardsStrings.newMaterialContentEmpty() : null,
                      onSaved: (val) => _content = val,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
