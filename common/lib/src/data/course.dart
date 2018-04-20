import 'package:flashcards_common/src/data/data.dart';

class CourseData extends Data {
  final String id;
  final String name;
  final String description;
  final double progress;
  final int stars;

//  todo implement creating new course with id
  CourseData(this.name, this.progress, this.description)
      : id = "",
        stars = 0;

  CourseData.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        description = data['description'],
        progress = data['progress'],
        stars = data['stars'];

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': '$id',
      'name': '$name',
      'description': '$description',
      'progress': progress,
      'stars': stars,
    };
  }
}
