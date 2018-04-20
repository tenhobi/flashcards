import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class UserData extends Data {
  final String uid;
  final int score;
  final String language;

  UserData({@required this.uid, this.language = 'en_US', this.score = 0});

  UserData.fromMap(Map<String, dynamic> data)
      : uid = data['uid'],
        score = data['score'] ?? 0,
        language = data['language'] ?? 'en_US';

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': '$uid',
      'score': score,
      'language': '$language',
    };
  }
}
