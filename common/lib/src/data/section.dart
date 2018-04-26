import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class SectionData extends Data implements Comparable<SectionData> {
  final String id;
  final CourseData parent;
  final String name;
  final int order;

  // fixme: id, parent and order
  SectionData(this.name)
      : id = '',
        parent = null,
        order = 0;

  SectionData.fromMap(Map<String, dynamic> data, {@required CourseData parent})
      : id = data['id'],
        parent = parent,
        name = data['name'],
        order = data['order'];

  @override
  int compareTo(SectionData d) => order.compareTo(d.order);

  @override
  Map<String, dynamic> toMap() {
    return {'id': '$id', 'name': '$name', 'order': '$order'};
  }
}
