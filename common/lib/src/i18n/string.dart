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
    return Intl.message('_sections', name: 'sectionsTab', desc: 'Sections tab in course screen');
  }

  static String descriptionTab() {
    return Intl.message('_description', name: 'descriptionTab', desc: 'Description tab in course screen');
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
}
