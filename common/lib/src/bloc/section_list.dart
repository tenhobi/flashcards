import 'dart:async';

import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:meta/meta.dart';


class SectionListBloc {
	final FirebaseApi _api;

	SectionListBloc(this._api);

	Stream<List<SectionData>> query({@required CourseData course}) {
		return _api.querySections(course: course);
	}

//	todo: implement this
//	void create(CourseData course) => _api.addCourse(course);
}
