import 'package:angular_router/angular_router.dart';

const String idCourse = 'id';

final RoutePath about = RoutePath(path: 'about');

final RoutePath course = RoutePath(path: 'course/:$idCourse');
final RoutePath courses = RoutePath(path: 'courses');

String getId(Map<String, String> parameters) {
  final id = parameters[idCourse];
  return id;
}
