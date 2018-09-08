import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';

class ExerciseData extends SubsectionData {
  final String type;

  ExerciseData({
    @required String id,
    @required SectionData parent,
    @required String name,
    @required this.type,
    int order = 0,
  }) : super(id: id, parent: parent, name: name, order: order);

  factory ExerciseData.fromMap({
    @required Map<String, dynamic> data,
    @required SectionData parent,
  }) =>
      ExerciseData(
        id: data['id'],
        parent: parent,
        name: data['name'],
        type: data['type'],
        order: data['order'],
      );

  @override
  Map<String, dynamic> toMap() {
    return {'id': '$id', 'name': '$name', 'type': '$type', 'order': order};
  }

  @override
  ExerciseData copyWith({String id, SectionData parent, String name, String type, int order}) => ExerciseData(
        id: id ?? this.id,
        parent: parent ?? this.parent,
        name: name ?? this.name,
        type: type ?? this.type,
        order: order ?? this.order,
      );
}
