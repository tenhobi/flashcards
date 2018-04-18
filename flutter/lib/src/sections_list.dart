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
					// fixme: use theme
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
						_SectionRow(
							icon: Icons.description,
							text: "Materials",
							onTap: (){}
						),
						_SectionRow(
							icon: Icons.create,
							text: "Excercise",
							onTap: (){},
							isLast: true,
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
				return ListView(
					children: snapshot.data.map((SectionData section) {
						return SectionWidget(section: section);
					}).toList()
				);
			},
		);
	}
}