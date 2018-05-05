import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';

class ExerciseData extends SubsectionData {
  // TODO: enhance constructors
  ExerciseData(String name, int order, SectionData parent) : super(name: name, order: order, parent: parent);

  ExerciseData.fromMap(Map<String, dynamic> data, {@required SectionData parent})
      : super(name: data['name'], order: data['order'], parent: parent);

  @override
  Map<String, dynamic> toMap() {
    return {'name': '$name', 'order': '$order'};
  }
}
