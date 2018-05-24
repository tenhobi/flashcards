import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class SectionData extends Data implements Comparable<SectionData> {
  final String id;
  final CourseData parent;
  final String name;
  final int order;

  // TODO: enhance constructors
  SectionData({@required this.name, this.parent, this.id = '', this.order = 0});

  factory SectionData.fromMap(Map<String, dynamic> data, {@required CourseData parent}) => SectionData(
        name: data['name'],
        id: data['id'],
        parent: parent,
        order: data['order'],
      );

  @override
  int compareTo(SectionData d) => order.compareTo(d.order);

  @override
  Map<String, dynamic> toMap() {
    return {'id': '$id', 'name': '$name', 'order': order};
  }
}
