import 'package:flashcards_common/src/data.dart';

class CourseData extends Data {
  final String name;
  final double progress;

  CourseData(this.name, this.progress);

  CourseData.fromMap(Map<String, dynamic> data)
      : name = data['name'],
        progress = data['progress'];

  @override
  Map<String, String> toMap() {
    return {
      'name': '$name',
      'progress': '$progress',
    };
  }
}
