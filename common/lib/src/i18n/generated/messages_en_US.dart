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

  static m1(sectionName) => "Editing ${sectionName}";

  static m2(subsectionName) => "Editing ${subsectionName}";

  static m3(score) => "score: ${score}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "aboutLicensesText": MessageLookupByLibrary.simpleMessage(
            "Application is being developed using open source software: [licences]()"),
        "aboutNavigationButton": MessageLookupByLibrary.simpleMessage("About"),
        "aboutText": m0,
        "addComment": MessageLookupByLibrary.simpleMessage("Add comment"),
        "addExercise": MessageLookupByLibrary.simpleMessage("Add exercise"),
        "addExerciseLabel": MessageLookupByLibrary.simpleMessage("Add exercise"),
        "addMaterial": MessageLookupByLibrary.simpleMessage("Add material"),
        "addMaterialLabel": MessageLookupByLibrary.simpleMessage("Add material"),
        "allCourses": MessageLookupByLibrary.simpleMessage("all"),
        "appName": MessageLookupByLibrary.simpleMessage("Flashcards"),
        "bioEmpty": MessageLookupByLibrary.simpleMessage("Please insert your bio."),
        "bioName": MessageLookupByLibrary.simpleMessage("Bio name"),
        "bioPlaceholder": MessageLookupByLibrary.simpleMessage("Bio placeholder"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cannotBeEmpty": MessageLookupByLibrary.simpleMessage("Cannot be empty"),
        "commentsTab": MessageLookupByLibrary.simpleMessage("Comments"),
        "createdCourses": MessageLookupByLibrary.simpleMessage("created"),
        "descriptionTab": MessageLookupByLibrary.simpleMessage("Description"),
        "editSectionLabel": m1,
        "editSubsectionLabel": m2,
        "flipcards": MessageLookupByLibrary.simpleMessage("Flipcards"),
        "generalEmpty": MessageLookupByLibrary.simpleMessage("This field cannot be empty"),
        "homeNavigationButton": MessageLookupByLibrary.simpleMessage("Home"),
        "like": MessageLookupByLibrary.simpleMessage("Like"),
        "linksName": MessageLookupByLibrary.simpleMessage("Links name"),
        "multipleChoice": MessageLookupByLibrary.simpleMessage("Multiple choice"),
        "nameEmpty": MessageLookupByLibrary.simpleMessage("Please insert your name."),
        "nameName": MessageLookupByLibrary.simpleMessage("Name"),
        "newCourse": MessageLookupByLibrary.simpleMessage("New course"),
        "newCourseDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "newCourseDescriptionEmpty": MessageLookupByLibrary.simpleMessage("Description cannot be empty."),
        "newCourseName": MessageLookupByLibrary.simpleMessage("Name"),
        "newCourseNameEmpty": MessageLookupByLibrary.simpleMessage("Name cannot be empty."),
        "newLink": MessageLookupByLibrary.simpleMessage("Add social network connection."),
        "newSection": MessageLookupByLibrary.simpleMessage("New section"),
        "newSectionName": MessageLookupByLibrary.simpleMessage("Name"),
        "newSectionNameEmpty": MessageLookupByLibrary.simpleMessage("Name cannot be empty."),
        "newSectionOrder": MessageLookupByLibrary.simpleMessage("Order of the section"),
        "newSectionOrderEmpty": MessageLookupByLibrary.simpleMessage("Order of the section cannot be empty."),
        "newSubsectionName": MessageLookupByLibrary.simpleMessage("_newSubsectionName"),
        "newSubsectionNameEmpty": MessageLookupByLibrary.simpleMessage("_newSubsectionNameEmpty"),
        "newSubsectionOrder": MessageLookupByLibrary.simpleMessage("_newSubsectionOrder"),
        "newSubsectionOrderEmpty": MessageLookupByLibrary.simpleMessage("_newSubsectionOrderEmpty"),
        "newUser": MessageLookupByLibrary.simpleMessage("New user"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "no": MessageLookupByLibrary.simpleMessage("No"),
        "noVersion": MessageLookupByLibrary.simpleMessage("No version found"),
        "numberOfQuestions": MessageLookupByLibrary.simpleMessage("Number of questions"),
        "popularCourses": MessageLookupByLibrary.simpleMessage("popular"),
        "previous": MessageLookupByLibrary.simpleMessage("Previous"),
        "profileScreenTitle": MessageLookupByLibrary.simpleMessage("Profile screen title"),
        "rememberThose": MessageLookupByLibrary.simpleMessage("Remember those."),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "removeCourseDialog": MessageLookupByLibrary.simpleMessage("Do you want to remove this course?"),
        "removeExerciseDialog": MessageLookupByLibrary.simpleMessage("Do you want to remove this exercise?"),
        "removeMaterialDialog": MessageLookupByLibrary.simpleMessage("Do you want to remove this material?"),
        "removeSectionDialog": MessageLookupByLibrary.simpleMessage("Do you want to remove this section?"),
        "reportBugNavigationButton": MessageLookupByLibrary.simpleMessage("Report bug"),
        "reportUrl": MessageLookupByLibrary.simpleMessage("https://github.com/tenhobi/flashcards/issues/new"),
        "savedUserData": MessageLookupByLibrary.simpleMessage("Your data has been saved"),
        "score": m3,
        "searchNavigationButton": MessageLookupByLibrary.simpleMessage("Search"),
        "sectionsTab": MessageLookupByLibrary.simpleMessage("Sections"),
        "settingsNavigationButton": MessageLookupByLibrary.simpleMessage("Settings"),
        "signInButton": MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "signOutNavigationButton": MessageLookupByLibrary.simpleMessage("Sign out"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "submitDetails": MessageLookupByLibrary.simpleMessage("Submit details"),
        "typeOfExercise": MessageLookupByLibrary.simpleMessage("Type of exercise"),
        "unlike": MessageLookupByLibrary.simpleMessage("Unlike"),
        "wrongInput": MessageLookupByLibrary.simpleMessage("Wrong input"),
        "yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
