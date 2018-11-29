import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:flashcards_angular/src/api/firebase_angular_api.dart';
import 'package:flashcards_common/data.dart';

import 'route_paths.dart' as paths;

@Component(
  selector: 'profile-component',
  template: '''
    <div class="link" (click)="goBack()">Zpět!</div>
    <div align='center' *ngIf="user != null">
      <img [attr.src]="user?.photoUrl" alt='profile picture'>
      <h1>{{user?.name}}</h1>
      <div class='info'>
      <h5>Score: {{user?.score}}</h5><h5>Language: {{user?.language}}</h5>
      </div>
      <a class="LinkedProfiles" *ngFor="let link of user.links" href="{{link?.linkType.baseUrl + link?.value}}">{{(link?.linkType.linkName())}}</a>
      <p>---------</p>
      <p>{{user?.bio}}</p>
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

  img {
    width: 300px;
  }

  .link {
    cursor: pointer;
  }

  .LinkedProfiles {
    margin: 20px;
  }

  .info {
    margin-bottom: 5px;
    margin-top: 5px;
  }

  h1 {
    margin-bottom: 0px;
  }

  h5 {
    display:inline;
    margin: 5px;
  }
''',
  ],
  directives: [coreDirectives],
)
class ProfileComponent implements OnActivate {
  UserData user;

  final Location _location;

  ProfileComponent(this._location);

  void goBack() => _location.back();

  @override
  void onActivate(_, RouterState current) {
    final id = paths.getId(current.parameters);

    FirebaseAngularApi().queryUser(id).listen((userData) {
      user = userData;
    });
  }
}
