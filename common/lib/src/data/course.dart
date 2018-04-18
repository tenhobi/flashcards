import 'package:flashcards_common/src/data/data.dart';

class CourseData extends Data {
  final String id;
  final String name;
  final double progress;

//  todo implement creating new course with id
  CourseData(this.name, this.progress) : id = "";

  CourseData.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        progress = data['progress'];

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': '$id',
      'name': '$name',
      'progress': progress,
    };
  }
}
