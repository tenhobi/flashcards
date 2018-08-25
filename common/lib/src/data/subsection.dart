import 'package:flashcards_common/src/data/data.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/exercise.dart';
import 'package:meta/meta.dart';

abstract class SubsectionData extends Data implements Comparable<SubsectionData> {
  final String id;
  final SectionData parent;
  final String name;
  final int order;

  SubsectionData({
    @required this.id,
    @required this.parent,
    @required this.name,
    @required this.order,
  });

  static String getTypeToString(SubsectionData data) => data is ExerciseData ? 'exercises' : 'materials';

  @override
  SubsectionData copyWith({String id, SectionData parent, String name, int order});

  @override
  int compareTo(SubsectionData other) => order.compareTo(other.order);
}
