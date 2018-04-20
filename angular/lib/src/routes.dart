// ignore_for_file: uri_has_not_been_generated
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'route_paths.dart' as paths;
import 'courses_component.template.dart' as ccs;
import 'course_component.template.dart' as cc;

@Injectable()
class Routes {
  static final _courses = new RouteDefinition(
    routePath: paths.courses,
    component: ccs.CoursesComponentNgFactory,
  );

  RouteDefinition get courses => _courses;

  static final _course = new RouteDefinition(
    routePath: paths.course,
    component: cc.CourseComponentNgFactory,
  );

  RouteDefinition get course => _course;

  final List<RouteDefinition> all = [
    _courses,
    _course,
  ];
}
