import 'package:flashcards_common/src/data/data.dart';
import 'package:meta/meta.dart';

class CommentData extends Data {
  final String authorUid;
  final String content;
  final String id;

  CommentData({
    @required this.authorUid,
    @required this.content,
    this.id,
  });

  factory CommentData.fromMap(Map<String, dynamic> data) => CommentData(
        id: data['id'],
        authorUid: data['authorUid'],
        content: data['content'],
      );

  @override
  CommentData copyWith({String authorUid, String id, String content}) => CommentData(
        authorUid: authorUid ?? this.authorUid,
        content: content ?? this.content,
        id: id ?? this.id,
      );

  @override
  Map<String, dynamic> toMap() {
    return {
      'authorUid': authorUid,
      'content': content,
    };
  }
}
