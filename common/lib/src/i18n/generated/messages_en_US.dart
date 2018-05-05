// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'en_US';

  static m0(version) =>
      "Version\n__${version}__\n\nOpen source project with a goal to develop a multiplatform (i.e. web, android, iOS) flashcards learning app. You can check our code on [GitHub](https://github.com/tenhobi/flashcards).\n\nThe project started as a part of a software team project at the [Faculty of Information Technology, CTU in Prague](https://fit.cvut.cz/en).";

  static m1(score) => "score: ${score}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "aboutLicensesText": MessageLookupByLibrary
            .simpleMessage("Application is being developed using open source software: [licences]()"),
        "aboutNavigationButton": MessageLookupByLibrary.simpleMessage("About"),
        "aboutText": m0,
        "allCourses": MessageLookupByLibrary.simpleMessage("all"),
        "appName": MessageLookupByLibrary.simpleMessage("Flashcards"),
        "createdCourses": MessageLookupByLibrary.simpleMessage("created"),
        "descriptionTab": MessageLookupByLibrary.simpleMessage("Description"),
        "homeNavigationButton": MessageLookupByLibrary.simpleMessage("Home"),
        "newCourse": MessageLookupByLibrary.simpleMessage("New course"),
        "newCourseDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "newCourseDescriptionEmpty": MessageLookupByLibrary.simpleMessage("Description cannot be empty."),
        "newCourseName": MessageLookupByLibrary.simpleMessage("Name"),
        "newCourseNameEmpty": MessageLookupByLibrary.simpleMessage("Name cannot be empty."),
        "noVersion": MessageLookupByLibrary.simpleMessage("No version found"),
        "popularCourses": MessageLookupByLibrary.simpleMessage("popular"),
        "reportBugNavigationButton": MessageLookupByLibrary.simpleMessage("Report bug"),
        "reportUrl": MessageLookupByLibrary.simpleMessage("https://github.com/tenhobi/flashcards/issues/new"),
        "score": m1,
        "searchNavigationButton": MessageLookupByLibrary.simpleMessage("Search"),
        "sectionsTab": MessageLookupByLibrary.simpleMessage("Sections"),
        "settingsNavigationButton": MessageLookupByLibrary.simpleMessage("Settings"),
        "signInButton": MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "signOutNavigationButton": MessageLookupByLibrary.simpleMessage("Sign out")
      };
}
