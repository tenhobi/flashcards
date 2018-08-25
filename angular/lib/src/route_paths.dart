import 'package:angular_router/angular_router.dart';

String getId(Map<String, String> parameters) {
  final id = parameters[idCourse];
  return id;
}

final courses = RoutePath(path: 'courses');

const idCourse = 'id';
final course = RoutePath(path: 'course/:$idCourse');
