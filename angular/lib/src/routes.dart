// ignore_for_file: uri_has_not_been_generated
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'about_component.template.dart' as ac;
import 'course_component.template.dart' as cc;
import 'courses_component.template.dart' as ccs;
import 'route_paths.dart' as paths;

@Injectable()
class Routes {
  static final _courses = RouteDefinition(
    routePath: paths.courses,
    component: ccs.CoursesComponentNgFactory,
  );

  static final _course = RouteDefinition(
    routePath: paths.course,
    component: cc.CourseComponentNgFactory,
  );

  static final _about = RouteDefinition(
    routePath: paths.about,
    component: ac.AboutComponentNgFactory,
  );

  final List<RouteDefinition> all = [
    _courses,
    _course,
    _about,
  ];

  RouteDefinition get about => _about;

  RouteDefinition get course => _course;

  RouteDefinition get courses => _courses;
}
