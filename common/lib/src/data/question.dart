import 'package:flashcards_common/src/data/data.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';

abstract class QuestionData extends Data {
  final String id;
  final SubsectionData parent;
  final String question;

  QuestionData({
    @required this.id,
    @required this.parent,
    @required this.question,
  });

  //static String getTypeToString(SubsectionData data) => data is ExerciseData ? 'exercises' : 'materials';

  @override
  QuestionData copyWith({String id, SubsectionData parent, String question});
}
