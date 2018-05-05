import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class UserData extends Data {
  final String uid;
  final int score;
  final String language;

  UserData({@required this.uid, this.language = 'en_US', this.score = 0});

  factory UserData.fromMap(Map<String, dynamic> data) => UserData(
        uid: data['uid'],
        score: data['score'],
        language: data['language'],
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': '$uid',
      'score': score,
      'language': '$language',
    };
  }
}
