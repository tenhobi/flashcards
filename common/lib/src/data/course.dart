import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class CourseData extends Data {
  final String id;
  final String name;
  final String authorUid;
  final String description;
  final double progress;
  final int stars;

  CourseData(
      {@required this.name,
      @required this.authorUid,
      this.description,
      this.stars = 0,
      this.id = "",
      this.progress = 0.0});

  CourseData.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        authorUid = data['authorUid'],
        description = data['description'],
        progress = data['progress'],
        stars = data['stars'];

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': '$id',
      'name': '$name',
      'description': '$description',
      'authorUid': '$authorUid',
      'progress': progress,
      'stars': stars,
    };
  }
}
