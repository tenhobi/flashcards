import 'package:flashcards_logic/src/data.dart';

class CourseData extends Data {
  final String name;
  final double progress;

  CourseData(this.name, this.progress);

  @override
  Map<String, String> toMap() {
    return {
      'name': '$name',
      'progress': '$progress',
    };
  }
}
