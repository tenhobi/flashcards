// ignore_for_file: uri_has_not_been_generated
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'course_component.template.dart' as cc;
import 'courses_component.template.dart' as ccs;
import 'about_component.template.dart' as ac;
import 'route_paths.dart' as paths;

@Injectable()
class Routes {
  static final _courses = RouteDefinition(
    routePath: paths.courses,
    component: ccs.CoursesComponentNgFactory,
  );

  RouteDefinition get courses => _courses;

  static final _course = RouteDefinition(
    routePath: paths.course,
    component: cc.CourseComponentNgFactory,
  );

  RouteDefinition get course => _course;

  static final _about = RouteDefinition(
    routePath: paths.about,
    component: ac.AboutComponentNgFactory,
  );

  RouteDefinition get about => _about;


  final List<RouteDefinition> all = [
    _courses,
    _course,
    _about,
  ];
}
