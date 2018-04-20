import 'package:flashcards_common/src/data/data.dart';
import 'package:flashcards_common/src/data/section.dart';
import 'package:meta/meta.dart';

abstract class SubsectionData extends Data implements Comparable<SubsectionData> {
  SubsectionData({@required this.name, @required this.order, @required this.parent});
  final int order;
  final SectionData parent;
  final String name;

  @override
  int compareTo(SubsectionData other) => order.compareTo(other.order);

  Map<String, dynamic> toMap();
}
