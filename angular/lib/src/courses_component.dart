import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart';
import 'package:flashcards_common/common.dart';

import 'route_paths.dart' as paths;

@Component(
  selector: 'courses-component',
  template: '''
  
  <div class="courses">
    <a class="course" *ngFor="let course of courses" >
      <div class="course__name" [routerLink]="courseUrl(course.id)">{{course?.name}}</div>
      <div class="course__stars">{{course?.stars}}</div>
    </a>
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
  List<CourseData> courses = [];

  String courseUrl(String id) => paths.course.toUrl(parameters: {paths.idCourse: id});

  @override
  void ngAfterViewInit() {
    fb.firestore().collection('courses').onSnapshot.listen((querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot snapshot) {
        Map<String, dynamic> courseData = snapshot.data();
        courseData.addAll({'id': snapshot.id});
        courses.add(new CourseData.fromMap(courseData));
      });
    });
  }
}
