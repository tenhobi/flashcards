import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';

class MaterialData extends SubsectionData {
  // TODO: enhance constructors
  MaterialData(String name, int order, SectionData parent) : super(name: name, order: order, parent: parent);

  MaterialData.fromMap(Map<String, dynamic> data, {@required SectionData parent})
      : super(id: data['id'], name: data['name'], order: data['order'], parent: parent);

  @override
  Map<String, dynamic> toMap() {
    return {'id': '$id', 'name': '$name', 'order': order};
  }
}
