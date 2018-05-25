import 'package:flashcards_common/src/data/data.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:meta/meta.dart';

enum SubsectionType{
  exercise, material
}

abstract class SubsectionData extends Data implements Comparable<SubsectionData> {
  final String id;
  final SectionData parent;
  final String name;
  final int order;

  // TODO: enhance constructors, do *.fromMap()
  SubsectionData({@required this.name, @required this.order, @required this.parent, this.id = ''});

  @override
  int compareTo(SubsectionData other) => order.compareTo(other.order);

  @override
  Map<String, dynamic> toMap();
}
