import 'package:intl/intl.dart';

class FlashcardsStrings {
  static String signInButton() {
    return Intl.message(
      '_signInButton',
      name: 'signInButton',
      desc: 'Sign in button.',
    );
  }

  static String sectionsTab() {
    return Intl.message(
      '_sections',
      name: 'sectionsTab',
      desc: 'Sections tab in course screen',
    );
  }

  static String descriptionTab() {
    return Intl.message(
      '_description',
      name: 'descriptionTab',
      desc: 'Description tab in course screen',
    );
  }

  static String homeNavigationButton() {
    return Intl.message(
      '_homeNavigationButton',
      name: 'homeNavigationButton',
      desc: 'Home button in navigation.',
    );
  }

  static String searchNavigationButton() {
    return Intl.message(
      '_searchNavigationButton',
      name: 'searchNavigationButton',
      desc: 'Search button in navigation.',
    );
  }

  static String aboutNavigationButton() {
    return Intl.message(
      '_aboutNavigationButton',
      name: 'aboutNavigationButton',
      desc: 'About button in navigation.',
    );
  }

  static String settingsNavigationButton() {
    return Intl.message(
      '_settingsNavigationButton',
      name: 'settingsNavigationButton',
      desc: 'Settings button in navigation.',
    );
  }

  static String reportBugNavigationButton() {
    return Intl.message(
      '_reportBugNavigationButton',
      name: 'reportBugNavigationButton',
      desc: 'Report button in navigation.',
    );
  }

  static String signOutNavigationButton() {
    return Intl.message(
      '_signOutNavigationButton',
      name: 'signOutNavigationButton',
      desc: 'Sign out button in navigation.',
    );
  }

  static String aboutText(String version) {
    return Intl.message(
      '''Version
__${version}__

Open source project with a goal to develop a multiplatform (i.e. web, android, iOS) flashcards learning app. You can check our code on [GitHub](https://github.com/tenhobi/flashcards).

The project started as a part of a software team project at the [Faculty of Information Technology, CTU in Prague](https://fit.cvut.cz/en).''',
      args: [version],
      name: 'aboutText',
      desc: 'Text about this application in markdown.',
    );
  }

  static String aboutLicensesText() {
    return Intl.message(
      'Application is being developed using open source software: [licences]()',
      name: 'aboutLicensesText',
      desc: 'Text about licences with an empty link as a button in markdown.',
    );
  }

  static String score(int score) {
    return Intl.message(
      'score: $score',
      args: [score],
      name: 'score',
      desc: 'Score caption.',
    );
  }

  static String appName() {
    return Intl.message(
      'Flashcards',
      name: 'appName',
      desc: 'Name of the application.',
    );
  }

  static String noVersion() {
    return Intl.message(
      'No version found',
      name: 'noVersion',
      desc: 'Version of the application has not been found.',
    );
  }

  static String allCourses() {
    return Intl.message(
      'all',
      name: 'allCourses',
      desc: 'Tab description of all courses.',
    );
  }

  static String createdCourses() {
    return Intl.message(
      'created',
      name: 'createdCourses',
      desc: 'Tab description of created courses.',
    );
  }

  static String popularCourses() {
    return Intl.message(
      'popular',
      name: 'popularCourses',
      desc: 'Tab description of popular courses.',
    );
  }

  static String newCourseName() {
    return Intl.message(
      'Name',
      name: 'newCourseName',
      desc: 'Label of input for name.',
    );
  }

  static String newCourseNameEmpty() {
    return Intl.message(
      'Name cannot be empty.',
      name: 'newCourseNameEmpty',
      desc: 'Error label of input for name about empty name.',
    );
  }

  static String newCourseDescription() {
    return Intl.message(
      'Description',
      name: 'newCourseDescription',
      desc: 'Label of input for description.',
    );
  }

  static String newCourseDescriptionEmpty() {
    return Intl.message(
      'Description cannot be empty.',
      name: 'newCourseDescriptionEmpty',
      desc: 'Error label of input for description about empty content.',
    );
  }

  static String reportUrl() {
    return Intl.message(
      'https://github.com/tenhobi/flashcards/issues/new',
      name: 'reportUrl',
      desc: 'Url of report bug page.',
    );
  }

  static String newCourse() {
    return Intl.message(
      'New course',
      name: 'newCourse',
      desc: 'Name of new course screen.',
    );
  }

  static String commentsTab() {
    return Intl.message(
      '_comments',
      name: 'commentsTab',
      desc: 'Comments tab in course screen.',
    );
  }

  static String removeCourseDialog() {
    return Intl.message(
      '_removeCourseDialog',
      name: 'removeCourseDialog',
      desc: 'Description of dialog for removing a course.',
    );
  }

  static String no() {
    return Intl.message(
      '_no',
      name: 'no',
      desc: 'No answer.',
    );
  }

  static String yes() {
    return Intl.message(
      '_yes',
      name: 'yes',
      desc: 'Yes answer.',
    );
  }

  static String remove() {
    return Intl.message(
      '_remove',
      name: 'remove',
      desc: 'Remove description.',
    );
  }

  static String like() {
    return Intl.message(
      '_like',
      name: 'like',
      desc: 'Like description.',
    );
  }

  static String unlike() {
    return Intl.message(
      '_unlike',
      name: 'unlike',
      desc: 'Unlike description.',
    );
  }

  static String addComment() {
    return Intl.message(
      '_add comment',
      name: 'addComment',
      desc: 'Add comment description.',
    );
  }

  static String cannotBeEmpty() {
    return Intl.message(
      '_cannot be empty',
      name: 'cannotBeEmpty',
      desc: 'Cannot be empty warning.',
    );
  }

  static String newSection() {
    return Intl.message(
      '_new section',
      name: 'newSection',
      desc: 'New section',
    );
  }

  static String newSectionName() {
    return Intl.message(
      '_name',
      name: 'newSectionName',
      desc: 'Label of input for name.',
    );
  }

  static String newSectionNameEmpty() {
    return Intl.message(
      '_name cannot be empty.',
      name: 'newSectionNameEmpty',
      desc: 'Error label of input for name about empty name.',
    );
  }

  static String newSectionOrder() {
    return Intl.message(
      '_newSectionOrder',
      name: 'newSectionOrder',
      desc: 'Label of input for order.',
    );
  }

  static String newSectionOrderEmpty() {
    return Intl.message(
      '_newSectionOrderEmpty',
      name: 'newSectionOrderEmpty',
      desc: 'Error label of input for order about empty order.',
    );
  }

  static String editSectionLabel(String sectionName) {
    return Intl.message(
      '_editting $sectionName',
      args: [sectionName],
      name: 'editSectionLabel',
      desc: 'Screen name for section editting.',
    );
  }

  static String addExercise() {
    return Intl.message(
      '_addExercise',
      name: 'addExercise',
      desc: 'Text shown within subsection list',
    );
  }

  static String addExerciseLabel() {
    return Intl.message(
      '_newExercise',
      name: 'addExerciseLabel',
      desc: 'Screen name for exercise subsection making.',
    );
  }

  static String addMaterial() {
    return Intl.message(
      '_addMaterial',
      name: 'addMaterial',
      desc: 'Text shown within subsection list',
    );
  }

  static String addMaterialLabel() {
    return Intl.message(
      '_newMaterial',
      name: 'addMaterialLabel',
      desc: 'Screen name for material subsection making.',
    );
  }

  static String removeExerciseDialog() {
    return Intl.message(
      '_removeExerciseDialog',
      name: 'removeExerciseDialog',
      desc: 'Description of dialog for removing a exercise.',
    );
  }

  static String removeMaterialDialog() {
    return Intl.message(
      '_removeMaterialDialog',
      name: 'removeMaterialDialog',
      desc: 'Description of dialog for removing a material.',
    );
  }

  static String removeSectionDialog() {
    return Intl.message(
      '_removeSectionDialog',
      name: 'removeSectionDialog',
      desc: 'Description of dialog for removing a section.',
    );
  }

  static String editSubsectionLabel(String subsectionName) {
    return Intl.message(
      '_editting $subsectionName',
      args: [subsectionName],
      name: 'editSubsectionLabel',
      desc: 'Screen name for subsection editting.',
    );
  }

  static String newSubsectionName() {
    return Intl.message(
      '_newSubsectionName',
      name: 'newSubsectionName',
      desc: 'Label of input for name.',
    );
  }

  static String newSubsectionNameEmpty() {
    return Intl.message(
      '_newSubsectionNameEmpty',
      name: 'newSubsectionNameEmpty',
      desc: 'Error label of input for name about empty name.',
    );
  }

  static String newSubsectionOrder() {
    return Intl.message(
      '_newSubsectionOrder',
      name: 'newSubsectionOrder',
      desc: 'Label of input for order.',
    );
  }

  static String newSubsectionOrderEmpty() {
    return Intl.message(
      '_newSubsectionOrderEmpty',
      name: 'newSubsectionOrderEmpty',
      desc: 'Error label of input for order about empty order.',
    );
  }

  static String typeOfExercise() {
    return Intl.message(
      '_type of exercise',
      name: 'typeOfExercise',
      desc: "Type of exercise description",
    );
  }

  static String flipcards() {
    return Intl.message(
      '_flipcards',
      name: 'flipcards',
      desc: 'Flip cards exercise type',
    );
  }

  static String multipleChoice() {
    return Intl.message(
      '_multiple choice',
      name: 'multipleChoice',
      desc: 'Multiple choice exercise type',
    );
  }

  static String numberOfQuestions() {
    return Intl.message(
      '_number of questions',
      name: 'numberOfQuestions',
      desc: 'Number of questions description',
    );
  }

  static String wrongInput() {
    return Intl.message(
      '_wrong input',
      name: 'wrongInput',
      desc: 'Wrong input warning',
    );
  }

  static String cancel() {
    return Intl.message(
      '_cancel',
      name: 'cancel',
      desc: 'Cancel answer',
    );
  }

  static String submit() {
    return Intl.message(
      '_submit',
      name: 'submit',
      desc: 'Submit answer',
    );
  }

  static String previous() {
    return Intl.message(
      '_previous',
      name: 'previous',
      desc: 'Previous button',
    );
  }

  static String next() {
    return Intl.message(
      '_next',
      name: 'next',
      desc: 'Next button',
    );
  }

  static String rememberThose() {
    return Intl.message(
      '_rememberthose.',
      name: 'rememberThose',
      desc: 'Remember those flipcards exercise',
    );
  }
}
