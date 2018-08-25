import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:flashcards_angular/src/courses_component.dart';
import 'package:flashcards_angular/src/routes.dart';

@Component(
  selector: 'flashcards-app',
  styleUrls: ['app_component.scss.css'],
  templateUrl: 'app_component.html',
  directives: [routerDirectives, CoursesComponent],
  providers: [
    ClassProvider(Routes),
  ],
)
class AppComponent {
  final Routes routes;

  AppComponent(this.routes);
}
