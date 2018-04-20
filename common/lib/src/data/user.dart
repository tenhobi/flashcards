import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class UserData extends Data {
  final String uid;
  final int score;

  UserData({@required this.uid, this.score});

  UserData.fromMap(Map<String, dynamic> data)
      : uid = data['uid'],
        score = data['score'] ?? 0 {}

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': '$uid',
      'score': score ?? 0,
    };
  }
}
