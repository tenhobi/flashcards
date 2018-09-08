import 'package:angular_router/angular_router.dart';

String getId(Map<String, String> parameters) {
  final id = parameters[idCourse];
  return id;
}

final RoutePath courses = RoutePath(path: 'courses');

const String idCourse = 'id';
final RoutePath course = RoutePath(path: 'course/:$idCourse');
