import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class CourseData extends Data {
  /// Firebase document ID
  final String id;

  final String name;

  final String authorUid;

  final String description;

  CourseData({
    @required this.name,
    @required this.authorUid,
    this.description = '',
    this.id = '',
  });

  factory CourseData.fromMap(Map<String, dynamic> data) => CourseData(
        name: data['name'],
        authorUid: data['authorUid'],
        description: data['description'],
        id: data['id'],
      );

  @override
  CourseData copyWith({
    String id,
    String name,
    String authorUid,
    String description,
  }) =>
      CourseData(
        id: id ?? this.id,
        name: name ?? this.name,
        authorUid: authorUid ?? this.authorUid,
        description: description ?? this.description,
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': '$name',
      'description': '$description',
      'authorUid': '$authorUid',
    };
  }
}
