import 'package:angular_router/angular_router.dart';

String getId(Map<String, String> parameters) {
  final id = parameters[dataID];
  return id;
}

final RoutePath courses = RoutePath(path: 'courses');

const String dataID = 'id';
final RoutePath course = RoutePath(path: 'course/:$dataID');

final RoutePath profile = RoutePath(path: 'profile/:$dataID');
