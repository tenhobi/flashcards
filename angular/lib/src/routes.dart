// ignore_for_file: uri_has_not_been_generated
import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'course_component.template.dart' as cc;
import 'courses_component.template.dart' as ccs;
import 'profile_component.template.dart' as prc;
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

  static final _profile = RouteDefinition(
    routePath: paths.profile,
    component: prc.ProfileComponentNgFactory,
  );

  RouteDefinition get profile => _profile;

  final List<RouteDefinition> all = [
    RouteDefinition.redirect(path: '/', redirectTo: '/courses'),
    _courses,
    _course,
    _profile,
  ];
}
