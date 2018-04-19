import 'package:flashcards_flutter/src/firebase_flutter_api.dart';
import 'package:flashcards_common/common.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class _SectionRow extends StatelessWidget {
	_SectionRow({@required this.icon, @required this.text, @required this.onTap, this.isLast = false});
	final IconData icon;
	final String text;
	final Function onTap;
	final bool isLast;

	static Widget Generate(SubsectionData d, {@required Function onTap, bool isLast = false}) {
		IconData icon = d is MaterialData ? Icons.description : Icons.create;
		return _SectionRow(
			icon: icon,
			text: d.name,
			onTap: onTap,
			isLast: isLast,
		);
	}

	@override
	Widget build(BuildContext context) {
		BorderRadius br;
		if(isLast) {
			br = BorderRadius.only(
				bottomLeft: Radius.circular(6.0),
				bottomRight: Radius.circular(6.0),
			);
		}

    return GestureDetector(
	    onTap: onTap,
	    child: Container(
		    padding: EdgeInsets.only(
			    left: 16.0,
			    bottom: 10.0,
			    right: 10.0,
			    top: 10.0
		    ),
		    alignment: Alignment.centerLeft,
		    decoration: BoxDecoration(
			    borderRadius: br,
			    color: Colors.white,
		    ),
		    child: Row(
			    mainAxisAlignment: MainAxisAlignment.start,
		      mainAxisSize: MainAxisSize.max,
		      children: <Widget>[
			      Icon(icon, color: Colors.black87, size: 22.0,),
			      Text(".", style: TextStyle(color: Colors.transparent),),
			      Expanded(
				      child: Text(text, style: TextStyle(color: Colors.black87, fontSize: 18.0))
			      )
		      ],
	      ),
	    )
    );
  }
}

class SectionWidget extends StatefulWidget {
	SectionWidget({@required SectionData this.section});

	final SectionData section;

	@override
	State<SectionWidget> createState() => _SectionsWidgetState();
}

class _SectionsWidgetState extends State<SectionWidget> {
	final SectionListBloc _bloc = SectionListBloc(FirebaseFlutterApi());

	List<SubsectionData> data = null;

	@override
	Widget build(BuildContext context) {
		BorderSide border = BorderSide(
				color: Theme.of(context).primaryColor,
				width: 2.0
		);

		return Container(
			padding: EdgeInsets.all(8.0),
			child: Container(
				decoration: BoxDecoration(
					color: Theme.of(context).primaryColor,
					borderRadius: BorderRadius.circular(8.0),
					border: Border(
						bottom: border,
						top: border,
						left: border,
						right: border,
					)
				),
				child: ExpansionTile(
					title: Container(
						child: Text(
								widget.section.name,
								style: TextStyle(color: Colors.white)
						),
					),
					children: <Widget>[
						StreamBuilder<List<SubsectionData>>(
							stream: _bloc.queryMaterialsAndExercises(section: widget.section),
							builder: (BuildContext context, AsyncSnapshot<List<SubsectionData>> snapshot) {
								print(data);
								if(!snapshot.hasData && (data == null || data.length == 0)) {
									return Container(
										padding: EdgeInsets.only(
											left: 10.0,
											bottom: 10.0,
											right: 10.0,
											top: 10.0
										),
										alignment: Alignment.center,
										decoration: BoxDecoration(
											borderRadius: BorderRadius.only(
												bottomLeft: Radius.circular(6.0),
												bottomRight: Radius.circular(6.0)
											),
											color: Colors.white,
										),
										child: Text("Empty")
									);
								}
								if(snapshot.data != null) {
									snapshot.data.sort();
									data = snapshot.data;
								}
								return Column(
									children: data.map((SubsectionData d) {
										bool last = false;
										if(data.last.compareTo(d) == 0) {
											last = true;
										}
										return _SectionRow.Generate(d, onTap: () {}, isLast: last);
									}).toList(),
								);
							},
						)
					],
				)
			)
		);
	}
}

class SectionsList extends StatefulWidget {
	final CourseData course;

	SectionsList({@required CourseData this.course});

	@override
	State<SectionsList> createState() => _SectionsListState();
}

class _SectionsListState extends State<SectionsList> {
	final SectionListBloc _bloc = SectionListBloc(FirebaseFlutterApi());

	@override
	Widget build(BuildContext context) {
		return StreamBuilder<List<SectionData>>(
			stream: _bloc.query(course: widget.course),
			builder: (BuildContext context, AsyncSnapshot<List<SectionData>> snapshot) {
				if(!snapshot.hasData) {
					return Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							CircularProgressIndicator()
						],
					);
				}
				snapshot.data.sort();
				return ListView(
					children: snapshot.data.map((SectionData section) {
						return SectionWidget(section: section);
					}).toList()
				);
			},
		);
	}
}