import 'package:angular/angular.dart';
import 'package:flashcards_logic/flashcards.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [],
  providers: const [],
)
class AppComponent {
  String myText = flashcardsMotto;
// Nothing here yet. All logic is in TodoListComponent.
}
