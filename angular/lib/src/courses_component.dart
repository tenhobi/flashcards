import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:flashcards_angular/src/api/firebase_angular_api.dart';
import 'package:flashcards_common/data.dart';
import 'package:rxdart/rxdart.dart';

import 'route_paths.dart' as paths;

@Component(
  selector: 'courses-component',
  pipes: [commonPipes],
  template: '''

  <div class="courses">
    <a class="course" *ngFor="let course of courses | async" >
      <div class="course__name" [routerLink]="courseUrl(course.id)">{{course?.name}}</div>
      <!-- <div class="course__stars" *ngFor="let stars of starsForCourse(course) | async">{{ stars?.length ?? 0 }}</div> -->
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
  ],
)
class CoursesComponent {
  final Observable<List<CourseData>> courses = FirebaseAngularApi().queryCourses();

  Stream<List<String>> starsForCourse(CourseData course) => FirebaseAngularApi().queryStars(course: course);

  String courseUrl(String id) => paths.course.toUrl(parameters: {paths.dataId: id});
  String profileUrl(String id) => paths.profile.toUrl(parameters: {paths.dataId: id});
  String aboutUrl() => paths.about.toUrl();
}
