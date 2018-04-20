import 'package:angular_router/angular_router.dart';

String getId(Map<String, String> parameters) {
  final id = parameters[idCourse];
  return id;
}

final courses = new RoutePath(path: 'courses');

const idCourse = 'id';
final course = new RoutePath(path: 'course/:$idCourse');
