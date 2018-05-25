import 'dart:async';
import 'package:flashcards_common/i18n.dart';
import 'package:flashcards_flutter/src/state/container.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:flashcards_common/data.dart';

class NewSubsectionScreen extends StatefulWidget {
	const NewSubsectionScreen({@required SectionData this.parent, @required SubsectionType this.type});
	final SectionData parent;
	final SubsectionType type;
  @override
  _NewSubsectionScreenState createState() => new _NewSubsectionScreenState();
}

class _NewSubsectionScreenState extends State<NewSubsectionScreen> {
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
						Stream<List<SubsectionData>> query;
						if(widget.type == SubsectionType.exercise) {
							query = state.sectionListBloc.queryExercises(section: widget.parent);
						} else {
							query = state.sectionListBloc.queryMaterials(section: widget.parent);
						}
						query.first.then(
							(List<SubsectionData> subsections) {
								SubsectionData data;
								if(widget.type == SubsectionType.exercise) {
									data = ExerciseData(_name, subsections.length, widget.parent);
								} else {
									data = MaterialData(_name, subsections.length, widget.parent);
								}

								state.sectionListBloc.createSubsection.add(
									Tuple2<SubsectionType, SubsectionData>(
										widget.type,
										data
									)
								);
								Navigator.of(context).pop();
							}
						);
					}
				},
				child: Icon(Icons.add),
			),
			appBar: AppBar(
				title: Text(widget.type == SubsectionType.exercise ?
					FlashcardsStrings.addExerciseLabel() : FlashcardsStrings.addMaterialLabel()
				),
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
