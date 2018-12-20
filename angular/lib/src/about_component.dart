import 'package:angular/angular.dart';
import 'package:angular/security.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:markdown/markdown.dart';
import 'package:angular_router/angular_router.dart';

@Component(
  selector: 'about-component',
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
  '''
  ],
  template: '''
    <div class="link" (click)="goBack()">Zpět!</div>

    <span [innerHTML]="aboutText"></span>
  ''',
  exports: [
    markdownToHtml,
    FlashcardsStrings,
  ],
  directives: [coreDirectives],
)
class AboutComponent {
  SafeHtml aboutText;
  DomSanitizationService sanitizer;

  final Location _location;

  void goBack() => _location.back();

  AboutComponent(this.sanitizer, this._location) {
    aboutText = sanitizer.bypassSecurityTrustHtml(markdownToHtml(FlashcardsStrings.aboutText('v1.0')));
  }
}
