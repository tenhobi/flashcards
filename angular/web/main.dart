/*import 'package:angular/angular.dart';

import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart';

void main() {
  fb.initializeApp(
      apiKey: 'AIzaSyDNbMmuLmmmpMEjnJz_M0SW1UKwnn40ZD0',
      authDomain: 'flashcards-a9d83.firebaseapp.com',
      databaseURL: 'https://flashcards-a9d83.firebaseio.com',
      projectId: 'flashcards-a9d83',
      storageBucket: 'flashcards-a9d83.appspot.com');

  Firestore firestore = fb.firestore();
  CollectionReference ref = firestore.collection("messages");

  ref.onSnapshot.listen((querySnapshot) {
    querySnapshot.docChanges.forEach((change) {
      if (change.type == "added") {
        // Do something with change.doc
      }
    });
  });
}*/

import 'package:angular/angular.dart';

// ignore: uri_has_not_been_generated
import 'package:flashcards_angular/app_component.template.dart' as ng;

void main() {
  runApp(ng.AppComponentNgFactory);
}
