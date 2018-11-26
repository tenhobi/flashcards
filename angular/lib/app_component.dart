import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flashcards_angular/src/api/authentication_angular_api.dart';
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
class AppComponent implements AfterViewInit {
  final Routes routes;

  AppComponent(this.routes);

  // TODO: how to get the data after reload?
  Future signIn() async {
    print(await AuthenticationAngularApi().signIn());
  }

  @override
  void ngAfterViewInit() {
    print(fb.auth()?.currentUser?.uid);
  }
}
