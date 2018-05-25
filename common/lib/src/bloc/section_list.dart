import 'dart:async';

import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';


class SectionListBloc extends Bloc {
  final FirebaseApi _api;

  final StreamController<SectionData> _createController = StreamController<SectionData>();
  final StreamController<Tuple2<SubsectionType, SubsectionData>> _createSubsectionController = StreamController<Tuple2<SubsectionType, SubsectionData>>();
  final StreamController<SectionData> _removeController = StreamController<SectionData>();
  final StreamController<SectionData> _editController = StreamController<SectionData>();

  SectionListBloc(this._api) {
    _createController.stream.listen(_handleCreate);
    _createSubsectionController.stream.listen(_handleCreateSubsection);
    _removeController.stream.listen(_handleRemove);
    _editController.stream.listen(_handleEdit);
  }

  Sink<SectionData> get create => _createController.sink;
  Sink<Tuple2<SubsectionType, SubsectionData>> get createSubsection => _createSubsectionController.sink;
  Sink<SectionData> get remove => _removeController.sink;
  Sink<SectionData> get edit => _editController.sink;

  Stream<List<SectionData>> query({@required CourseData course}) {
    return _api.querySections(course: course);
  }

  Stream<List<SubsectionData>> queryMaterials({@required SectionData section}) {
    return _api.queryMaterials(section: section);
  }

  Stream<List<SubsectionData>> queryExercises({@required SectionData section}) {
    return _api.queryExercises(section: section);
  }

  void _handleCreate(SectionData section) => _api.addSection(section);
  void _handleCreateSubsection(Tuple2<SubsectionType, SubsectionData> data) => _api.addSubsection(type: data.item1, subsection: data.item2);
  void _handleRemove(SectionData section) => _api.removeSection(section);
  void _handleEdit(SectionData section) => _api.editSection(section);

  @override
  void dispose() {
    _createController.close();
    _createSubsectionController.close();
    _removeController.close();
    _editController.close();
  }
}
