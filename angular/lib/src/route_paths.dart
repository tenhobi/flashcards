import 'package:angular_router/angular_router.dart';

const String dataId = 'id';

final RoutePath about = RoutePath(path: 'about');
final RoutePath course = RoutePath(path: 'course/:$dataId');
final RoutePath courses = RoutePath(path: 'courses');
final RoutePath profile = RoutePath(path: 'profile/:$dataId');

String getId(Map<String, String> parameters) {
  final id = parameters[dataId];
  return id;
}
