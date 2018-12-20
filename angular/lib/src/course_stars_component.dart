import 'package:angular/angular.dart';
import 'package:flashcards_angular/src/api/firebase_angular_api.dart';
import 'package:flashcards_common/data.dart';

@Component(
  selector: 'course-stars-component',
  template: '''
  {{ (starsForCourse | async)?.length ?? 0 }}
  ''',
  directives: [coreDirectives],
  pipes: [commonPipes],
)
class CourseStarsComponent implements OnInit {
  @Input()
  CourseData course;

  Stream<List<String>> starsForCourse;

  @override
  void ngOnInit() {
    starsForCourse = FirebaseAngularApi().queryStars(course: course);
  }
}
