import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';

import 'package:flashcards_common/data.dart';

class EditSectionScreen extends StatefulWidget {
  const EditSectionScreen({@required this.original});

  final SectionData original;

  @override
  _EditSectionScreenState createState() => _EditSectionScreenState();
}

class _EditSectionScreenState extends State<EditSectionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            final newData = SectionData(
              name: _name,
              order: _order,
              parent: widget.original.parent,
              id: widget.original.id,
            );

            state.sectionListBloc.edit.add(newData);
            Navigator.of(context).pop();
          }
        },
        child: Icon(Icons.check),
      ),
      appBar: AppBar(
        title: Text(FlashcardsStrings.editSectionLabel(_name)),
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
                initialValue: _name,
                validator: (val) => val.isEmpty ? FlashcardsStrings.newSectionNameEmpty() : null,
                onSaved: (val) => _name = val,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: FlashcardsStrings.newSectionOrder(),
                ),
                initialValue: _order.toString(),
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                validator: (val) => val.isEmpty ? FlashcardsStrings.newSectionOrderEmpty() : null,
                onSaved: (val) => _order = int.parse(val),
              )
            ],
          ),
        ),
      ),
    );
  }
}
