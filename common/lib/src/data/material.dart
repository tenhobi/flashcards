import 'package:flashcards_common/src/data/section.dart';
import 'package:flashcards_common/src/data/subsection.dart';
import 'package:meta/meta.dart';

class MaterialData extends SubsectionData {
  String content;

  MaterialData({
    String id,
    SectionData parent,
    String name,
    int order,
    this.content,
  }) : super(id: id, parent: parent, name: name, order: order);

  factory MaterialData.fromMap({
    @required Map<String, dynamic> data,
    @required SectionData parent,
  }) =>
      MaterialData(
        id: data['id'],
        parent: parent,
        name: data['name'],
        order: data['order'],
        content: data['content'],
      );

  @override
  Map<String, dynamic> toMap() {
    return {'id': '$id', 'name': '$name', 'order': order, 'content': content};
  }

  @override
  MaterialData copyWith({String id, SectionData parent, String name, int order, String content}) => MaterialData(
        id: id ?? this.id,
        parent: parent ?? this.parent,
        name: name ?? this.name,
        order: order ?? this.order,
        content: content ?? this.content,
      );
}
