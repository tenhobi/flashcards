import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:flashcards_angular/src/api/firebase_angular_api.dart';
import 'package:flashcards_common/data.dart';
import 'package:rxdart/rxdart.dart';

import 'course_stars_component.dart';
import 'route_paths.dart' as paths;

@Component(
  selector: 'courses-component',
  pipes: [commonPipes],
  template: '''

  <div class="courses">
    <a class="course" *ngFor="let course of courses | async" >
      <div class="course__name" [routerLink]="courseUrl(course.id)">{{course?.name}}</div>
      <course-stars-component class="course__stars" [course]="course"></course-stars-component>
    </a>
  </div>

  <div class="users">
    <div>
      <span class="link" [routerLink]="aboutUrl()">About app</span>
    </div>
    Example users:
    <div>
      <span class="link" [routerLink]="profileUrl('CsLhYmf4IQetdi2LDOA8Rjuo2U63')">User1</span>
    </div>
    <div>
      <span class="link" [routerLink]="profileUrl('HIx9rZUjKuQ8thgbZvO1TvvCwpI2')">User2</span>
    </div>
  </div>
  ''',
  styles: [
    '''
  :host {
    display: block;
    margin: 0 auto;
    max-width: 900px;
    width: 90%;
    padding: 50px;
  }

  .users {
    margin-top: 50px;
  }

  .link {
    cursor: pointer;
  }

  .courses {
    display: grid;
    grid-template-rows: repeat(auto-fill, 200px);
    grid-template-columns: repeat(auto-fill, 200px);
    grid-gap: 20px;
  }

  .course {
    width: 200px;
    height: 200px;
    display: grid;
    grid-template-rows: 1fr 20px;
    background: #006AFF;
    border-radius: 15px;
    overflow: hidden;
    color: #fff;
    cursor: pointer;
  }

  .course__name,
  .course__stars {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .course__name {
    font-size: 42px;
    font-weight: bold;
    text-align: center;
  }
''',
  ],
  directives: [
    coreDirectives,
    routerDirectives,
    CourseStarsComponent,
  ],
)
class CoursesComponent {
  final Observable<List<CourseData>> courses = FirebaseAngularApi().queryCourses();

  String aboutUrl() => paths.about.toUrl();

  String courseUrl(String id) => paths.course.toUrl(parameters: {paths.dataId: id});
  String profileUrl(String id) => paths.profile.toUrl(parameters: {paths.dataId: id});
}
