import 'dart:async';
import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/exercise.dart';
import 'package:flashcards_common/src/data/question.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:rxdart/rxdart.dart';

class ExerciseBloc extends Bloc {
  final FirebaseApi _api;

  final _createController = StreamController<QuestionData>();
  final _removeController = StreamController<QuestionData>();
  final _editController = StreamController<QuestionData>();

  ExerciseBloc(this._api) {
    _createController.stream.listen(_handleCreate);
    _removeController.stream.listen(_handleRemove);
    _editController.stream.listen(_handleEdit);
  }

  Sink<QuestionData> get create => _createController.sink;

  Sink<QuestionData> get remove => _removeController.sink;

  Sink<QuestionData> get edit => _editController.sink;

  Observable<List<QuestionData>> queryQuestions(ExerciseData exercise, int size) {
    return _api.queryQuestions(exercise: exercise, size: size);
  }

  void _handleCreate(QuestionData question) => _api.addQuestion(question);

  void _handleRemove(QuestionData question) => _api.removeQuestion(question);

  void _handleEdit(QuestionData question) => _api.editQuestion(question);

  @override
  void dispose() {
    _createController.close();
    _removeController.close();
    _editController.close();
  }
}
