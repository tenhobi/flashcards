import 'package:angular/angular.dart';
import 'package:flashcards_angular/src/api/firebase_angular_api.dart';
import 'package:flashcards_common/data.dart';

@Component(
  selector: 'user-name-component',
  template: '''
  {{ (user | async)?.name ?? 'unknown' }}
  ''',
  directives: [coreDirectives],
  pipes: [commonPipes],
)
class UserNameComponent implements OnInit {
  @Input()
  String userId;

  Stream<UserData> user;

  @override
  void ngOnInit() {
    user = FirebaseAngularApi().queryUser(userId);
  }
}
