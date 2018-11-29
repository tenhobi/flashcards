import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:firebase/firebase.dart' as fb;
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
      <!--<div class="course__stars">{{course?.stars}}</div>-->
    </a>
    <div [routerLink]="profileUrl('CsLhYmf4IQetdi2LDOA8Rjuo2U63')">User1</div>
    <div [routerLink]="profileUrl('HIx9rZUjKuQ8thgbZvO1TvvCwpI2')">User2</div>
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
class CoursesComponent implements AfterViewInit {
  Observable<List<CourseData>> courses = FirebaseFlutterApi().queryCourses();

  String courseUrl(String id) => paths.course.toUrl(parameters: {paths.dataID: id});
  String profileUrl(String id) => paths.profile.toUrl(parameters: {paths.dataID: id});

  @override
  void ngAfterViewInit() {}
}
