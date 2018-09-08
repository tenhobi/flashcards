import 'package:flashcards_common/src/data/subsection.dart';
import 'package:flashcards_common/src/data/question.dart';
import 'package:meta/meta.dart';

class FlipcardQuestionData extends QuestionData {
  final String answer;

  FlipcardQuestionData({
    @required String id,
    @required SubsectionData parent,
    @required String question,
    @required this.answer,
  }) : super(id: id, parent: parent, question: question);

  factory FlipcardQuestionData.fromMap({
    @required Map<String, dynamic> data,
    @required SubsectionData parent,
  }) =>
      FlipcardQuestionData(
        id: data['id'],
        parent: parent,
        question: data['question'],
        answer: data['answer'],
      );

  @override
  Map<String, dynamic> toMap() {
    return {'id': '$id', 'question': '$question', 'answer': "$answer"};
  }

  @override
  FlipcardQuestionData copyWith({String id, SubsectionData parent, String question, String answer}) =>
      FlipcardQuestionData(
        id: id ?? this.id,
        parent: parent ?? this.parent,
        question: question ?? this.question,
        answer: answer ?? this.answer,
      );
}
