import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_common/data.dart';

class EditSubsectionScreen extends StatefulWidget {
  const EditSubsectionScreen({@required SubsectionData this.original});
  final SubsectionData original;
  @override
  _EditSubsectionScreenState createState() => new _EditSubsectionScreenState();
}

class _EditSubsectionScreenState extends State<EditSubsectionScreen> {
  final formKey = new GlobalKey<FormState>();

  String _name;
  int _order;

  @override
  void initState() {
    super.initState();
    setState(() {
      _name = widget.original.name;
      _order = widget.original.order;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    print(widget.original.toMap());
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            SubsectionData newData;
            newData = widget.original.copyWith(name: _name, order: _order);
            state.sectionListBloc.editSubsection.add(newData);
            Navigator.of(context).pop();
          }
        },
        child: Icon(Icons.check),
      ),
      appBar: AppBar(
        title: Text(FlashcardsStrings.editSubsectionLabel(_name)),
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
                  labelText: FlashcardsStrings.newSubsectionName(),
                ),
                initialValue: _name,
                validator: (val) => val.isEmpty ? FlashcardsStrings.newSubsectionNameEmpty() : null,
                onSaved: (val) => _name = val,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: FlashcardsStrings.newSubsectionOrder(),
                ),
                initialValue: _order.toString(),
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                validator: (val) => val.isEmpty ? FlashcardsStrings.newSubsectionOrderEmpty() : null,
                onSaved: (val) => _order = int.parse(val),
              )
            ],
          ),
        ),
      ),
    );
  }
}
