import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:firebase/firebase.dart' as fb;
import 'package:flashcards_angular/src/api/firebase_angular_api.dart';
import 'package:flashcards_common/data.dart';

import 'package:markdown/markdown.dart';
import 'package:rxdart/rxdart.dart';

import 'route_paths.dart' as paths;

@Component(
  selector: 'course-component',
  pipes: [commonPipes],
  template: '''
    <div class="link" (click)="goBack()">Zpět!</div>

    <div *ngIf="course != null">
      <h1>{{course?.name}}</h1>
      <h2>Description</h2>
      <p>----</p>
      <p [innerHtml]="markdown(course?.description)"></p>
      <p>----</p>
      <div class="section" *ngFor="let section of sections | async" >
        <h3>{{section?.name}}</h3>
      </div>
      <!--<h3>Stars: {{course?.stars}}</h3>-->
    </div>
  ''',
  styles: [
    '''
  :host {
    padding: 30px;
    display: block;
    margin: 0 auto;
    max-width: 900px;
    width: 90%;
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
    background: #006aff;
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
  directives: [coreDirectives],
)
class CourseComponent implements OnActivate {
  CourseData course;

  Observable<List<SectionData>> sections;

  final Location _location;

  CourseComponent(this._location);

  void goBack() => _location.back();

  String markdown(String data) {
    return markdownToHtml(data);
  }

  @override
  void onActivate(_, RouterState current) {
    final id = paths.getId(current.parameters);

    fb.firestore().collection('courses').doc(id).onSnapshot.listen((querySnapshot) {
      var courseData = querySnapshot.data();
      courseData.addAll({'id': querySnapshot.id});
      course = CourseData.fromMap(courseData);

      sections = FirebaseAngularApi().querySections(course: course);
    });
  }
}
