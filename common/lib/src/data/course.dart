import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class CourseData extends Data {
  final String id;
  final String name;
  final String authorUid;
  final String description;
  final int stars;

  CourseData({
    @required this.name,
    @required this.authorUid,
    this.description = '',
    this.stars = 0,
    this.id = '',
  });

  factory CourseData.fromMap(Map<String, dynamic> data) => CourseData(
        name: data['name'],
        authorUid: data['authorUid'],
        description: data['description'],
        stars: data['stars'],
        id: data['id'],
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': '$id',
      'name': '$name',
      'description': '$description',
      'authorUid': '$authorUid',
      'stars': stars,
    };
  }
}
