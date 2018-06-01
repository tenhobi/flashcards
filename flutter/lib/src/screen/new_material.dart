import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_common/data.dart';

class NewMaterialScreen extends StatefulWidget {
  const NewMaterialScreen({@required SectionData this.parent});
  final SectionData parent;
  @override
  _NewMaterialScreenState createState() => new _NewMaterialScreenState();
}

class _NewMaterialScreenState extends State<NewMaterialScreen> {
  final formKey = new GlobalKey<FormState>();

  String _name;

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);

    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            state.sectionListBloc.queryMaterials(section: widget.parent).first.then((List<SubsectionData> materials) {
              final MaterialData data =
                  MaterialData(id: '', parent: widget.parent, name: _name, order: materials.length);
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
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: FlashcardsStrings.newSectionName(),
                ),
                validator: (val) => val.isEmpty ? FlashcardsStrings.newSectionNameEmpty() : null,
                onSaved: (val) => _name = val,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
