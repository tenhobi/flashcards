import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flashcards_angular/app_component.template.dart' as ng;
import 'package:flashcards_common/i18n.dart';

import 'main.template.dart' as self;

@GenerateInjector(
  routerProvidersHash, // You can use routerProviders in production
)
final InjectorFactory injector = self.injector$Injector;

void main() async {
  // TODO: it probably doesn't work?
  final locale = 'cz_CS';
  await initializeMessages(locale);

  fb.initializeApp(
      apiKey: 'AIzaSyDNbMmuLmmmpMEjnJz_M0SW1UKwnn40ZD0',
      authDomain: 'flashcards-a9d83.firebaseapp.com',
      databaseURL: 'https://flashcards-a9d83.firebaseio.com',
      projectId: 'flashcards-a9d83',
      storageBucket: 'flashcards-a9d83.appspot.com');

  runApp(ng.AppComponentNgFactory, createInjector: injector);
}
