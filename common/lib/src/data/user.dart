import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class UserData extends Data {
  final String uid;
  final int score;
  final String language;
  final String name;

  UserData({@required this.uid, @required this.name, this.language = 'en_US', this.score = 0});

  factory UserData.fromMap(Map<String, dynamic> data) => UserData(
        uid: data['uid'],
        name: data['name'],
        score: data['score'],
        language: data['language'],
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': '$uid',
      'name': '$name',
      'score': score,
      'language': '$language',
    };
  }
}
