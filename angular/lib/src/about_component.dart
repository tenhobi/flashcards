import 'package:angular/angular.dart';
import 'package:angular/security.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:markdown/markdown.dart';

@Component(
  selector: 'about-component',
  template: '''
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

  AboutComponent(this.sanitizer) {
    aboutText = sanitizer.bypassSecurityTrustHtml(markdownToHtml(FlashcardsStrings.aboutText('v1.0')));
  }
}
