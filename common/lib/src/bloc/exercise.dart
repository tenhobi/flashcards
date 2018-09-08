import 'dart:async';

import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/exercise.dart';
import 'package:flashcards_common/src/data/question.dart';
import 'package:flashcards_common/src/api/firebase.dart';

class ExerciseBloc extends Bloc {
  final FirebaseApi _api;

  ExerciseBloc(this._api);

  Stream<List<QuestionData>> queryQuestions(ExerciseData exercise, int size) {
    return _api.queryQuestions(exercise: exercise, size: size);
  }

  @override
  void dispose() {}
}
