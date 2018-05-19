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
  Map<String, dynamic> toMap() {
    return {
      'name': '$name',
      'description': '$description',
      'authorUid': '$authorUid',
    };
  }
}
