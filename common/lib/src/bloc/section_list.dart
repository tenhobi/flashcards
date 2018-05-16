import 'dart:async';

import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';

class SectionListBloc extends Bloc {
  final FirebaseApi _api;

  final StreamController<SubsectionData> _createController = StreamController<SubsectionData>();

  SectionListBloc(this._api) {
    _createController.stream.listen(_handleCreate);
  }

  Sink<SubsectionData> get create => _createController.sink;

  Stream<List<SectionData>> query({@required CourseData course}) {
    return _api.querySections(course: course);
  }

  Stream<List<SubsectionData>> queryMaterials({@required SectionData section}) {
    return _api.queryMaterials(section: section);
  }

  Stream<List<SubsectionData>> queryExercises({@required SectionData section}) {
    return _api.queryExercises(section: section);
  }

  void _handleCreate(SubsectionData section) => _api.addSection(section);

  @override
  void dispose() {
    _createController.close();
  }
}
