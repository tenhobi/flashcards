import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:firebase/firebase.dart' as fb;
import 'package:flashcards_common/data.dart';

import 'package:markdown/markdown.dart';
import 'package:flashcards_common/i18n.dart';
import 'package:angular/security.dart';


import 'route_paths.dart' as paths;

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
  var aboutText;
  DomSanitizationService sanitizer;

  AboutComponent(this.sanitizer) {
    aboutText = sanitizer.bypassSecurityTrustHtml(
      markdownToHtml(FlashcardsStrings.aboutText('v1.0')));
  }
}
