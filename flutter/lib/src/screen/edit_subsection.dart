import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_common/data.dart';

class EditSubsectionScreen extends StatefulWidget {
  const EditSubsectionScreen({@required this.original});

  final SubsectionData original;

  @override
  _EditSubsectionScreenState createState() => _EditSubsectionScreenState();
}

class _EditSubsectionScreenState extends State<EditSubsectionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _name;
  int _order;
  String _content;

  @override
  void initState() {
    super.initState();
    setState(() {
      _name = widget.original.name;
      _order = widget.original.order;

      if (widget.original is MaterialData) {
        _content = (widget.original as MaterialData).content;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = StateContainer.of(context);
    print(widget.original.toMap());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final form = formKey.currentState;

          if (form.validate()) {
            form.save();
            SubsectionData newData;

            if (widget.original is MaterialData) {
              newData = (widget.original as MaterialData).copyWith(name: _name, order: _order, content: _content);
            } else {
              newData = widget.original.copyWith(name: _name, order: _order);
            }

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
              ),
              _buildMaterialRelated(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialRelated(BuildContext context) {
    if (widget.original is MaterialData) {
      return TextFormField(
        maxLines: 7,
        decoration: InputDecoration(
          labelText: 'info',
        ),
        initialValue: _content.toString() ?? '',
        validator: (val) => val.isEmpty ? FlashcardsStrings.cannotBeEmpty() : null,
        onSaved: (val) => _content = val,
      );
    }

    return Container();
  }
}
