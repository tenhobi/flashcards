import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class CommentData extends Data {
  final String authorUid;
  final String content;
  final String id;

  CommentData({@required this.authorUid, @required this.content, this.id});

  factory CommentData.fromMap(Map<String, dynamic> data) => CommentData(
        id: data['id'],
        authorUid: data['authorUid'],
        content: data['content'],
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      'authorUid': authorUid,
      'content': content,
    };
  }
}
