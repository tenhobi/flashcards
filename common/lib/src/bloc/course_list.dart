import 'dart:async';

import 'package:flashcards_common/src/bloc/bloc.dart';
import 'package:flashcards_common/src/data/comment.dart';
import 'package:flashcards_common/src/data/course.dart';
import 'package:flashcards_common/src/api/firebase.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';
import 'package:rxdart/rxdart.dart';

export 'package:flashcards_common/src/api/firebase.dart' show CoursesQueryType;

class CourseListBloc extends Bloc {
  final FirebaseApi _api;

  final _likeCommentController = StreamController<Tuple3<CourseData, CommentData, String>>();
  final _unlikeCommentController = StreamController<Tuple3<CourseData, CommentData, String>>();
  final _addCommentController = StreamController<Tuple2<CourseData, CommentData>>();
  final _likeController = StreamController<Tuple2<CourseData, String>>();
  final _unlikeController = StreamController<Tuple2<CourseData, String>>();
  final _createController = StreamController<CourseData>();
  final _removeController = StreamController<CourseData>();

  CourseListBloc(this._api) {
    _likeCommentController.stream.listen(_handleLikeComment);
    _unlikeCommentController.stream.listen(_handleUnlikeComment);
    _addCommentController.stream.listen(_handleAddComment);
    _likeController.stream.listen(_handleLike);
    _unlikeController.stream.listen(_handleUnlike);
    _createController.stream.listen(_handleCreate);
    _removeController.stream.listen(_handleRemove);
  }

  Sink<Tuple3<CourseData, CommentData, String>> get likeComment => _likeCommentController.sink;

  Sink<Tuple3<CourseData, CommentData, String>> get unlikeComment => _unlikeCommentController.sink;

  Sink<Tuple2<CourseData, CommentData>> get addComment => _addCommentController.sink;

  Sink<Tuple2<CourseData, String>> get like => _likeController.sink;

  Sink<Tuple2<CourseData, String>> get unlike => _unlikeController.sink;

  Sink<CourseData> get create => _createController.sink;

  Sink<CourseData> get remove => _removeController.sink;

  Observable<List<CourseData>> queryAll(CoursesQueryType type, {String authorUid, String name}) {
    return _api.queryCourses(type: type, authorUid: authorUid, name: name);
  }

  Observable<List<String>> queryStars({@required CourseData course}) {
    return _api.queryStars(course: course);
  }

  Observable<List<String>> queryCommentsStars({@required CourseData course, @required CommentData comment}) {
    return _api.queryCommentsStars(course: course, comment: comment);
  }

  Observable<List<CommentData>> queryComments({@required CourseData course}) {
    return _api.queryComments(course);
  }

  void _handleLikeComment(Tuple3<CourseData, CommentData, String> data) =>
      _api.likeComment(course: data.item1, comment: data.item2, authorUid: data.item3);

  void _handleUnlikeComment(Tuple3<CourseData, CommentData, String> data) =>
      _api.unlikeComment(course: data.item1, comment: data.item2, authorUid: data.item3);

  void _handleAddComment(Tuple2<CourseData, CommentData> data) =>
      _api.addComment(course: data.item1, comment: data.item2);

  void _handleLike(Tuple2<CourseData, String> data) => _api.like(course: data.item1, userUid: data.item2);

  void _handleUnlike(Tuple2<CourseData, String> data) => _api.unlike(course: data.item1, userUid: data.item2);

  void _handleCreate(CourseData course) => _api.addCourse(course);

  void _handleRemove(CourseData course) => _api.removeCourse(course);

  @override
  void dispose() {
    _likeController.close();
    _unlikeController.close();
    _createController.close();
    _removeController.close();
  }
}
