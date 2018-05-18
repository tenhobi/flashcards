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
}
