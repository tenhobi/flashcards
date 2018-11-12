import 'dart:async';

import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class SectionListBloc extends Bloc {
  final FirebaseApi _api;

  final _createController = StreamController<SectionData>();
  final _removeController = StreamController<SectionData>();
  final _editController = StreamController<SectionData>();
  final _createSubsectionController = StreamController<SubsectionData>();
  final _removeSubsectionController = StreamController<SubsectionData>();
  final _editSubsectionController = StreamController<SubsectionData>();

  SectionListBloc(this._api) {
    _createController.stream.listen(_handleCreate);
    _removeController.stream.listen(_handleRemove);
    _editController.stream.listen(_handleEdit);
    _createSubsectionController.stream.listen(_handleCreateSubsection);
    _removeSubsectionController.stream.listen(_handleRemoveSubsection);
    _editSubsectionController.stream.listen(_handleEditSubsection);
  }

  Sink<SectionData> get create => _createController.sink;

  Sink<SectionData> get remove => _removeController.sink;

  Sink<SectionData> get edit => _editController.sink;

  Sink<SubsectionData> get createSubsection => _createSubsectionController.sink;

  Sink<SubsectionData> get removeSubsection => _removeSubsectionController.sink;

  Sink<SubsectionData> get editSubsection => _editSubsectionController.sink;

  Observable<List<SectionData>> query({@required CourseData course}) {
    return _api.querySections(course: course);
  }

  Observable<List<SubsectionData>> queryMaterials({@required SectionData section}) {
    return _api.queryMaterials(section: section);
  }

  Observable<List<SubsectionData>> queryExercises({@required SectionData section}) {
    return _api.queryExercises(section: section);
  }

  void _handleCreate(SectionData section) => _api.addSection(section);

  void _handleRemove(SectionData section) => _api.removeSection(section);

  void _handleEdit(SectionData section) => _api.editSection(section);

  void _handleCreateSubsection(SubsectionData subsection) => _api.addSubsection(subsection);

  void _handleRemoveSubsection(SubsectionData subsection) => _api.removeSubsection(subsection);

  void _handleEditSubsection(SubsectionData subsection) => _api.editSubsection(subsection);

  @override
  void dispose() {
    _createController.close();
    _removeController.close();
    _editController.close();
    _createSubsectionController.close();
    _removeSubsectionController.close();
    _editSubsectionController.close();
  }
}
