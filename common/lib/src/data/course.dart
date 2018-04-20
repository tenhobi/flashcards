import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class CourseData extends Data {
  final String name;
  final int stars;
  final String authorUid;

  CourseData({@required this.name, @required this.authorUid, this.stars = 0});

  CourseData.fromMap(Map<String, dynamic> data)
      : name = data['name'],
        stars = data['stars'],
        authorUid = data['authorUid'];

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': '$name',
      'stars': stars,
      'authorUid': '$authorUid',
    };
  }
}
