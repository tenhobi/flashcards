# FlashCards

[![Build Status](https://travis-ci.com/tenhobi/flashcards.svg?branch=master)](https://travis-ci.com/tenhobi/flashcards)

Software team project with a goal to develop a multiplatform (i.e. web & android & iOS) flashcards learning app.

## Contributing

Spotted an error? Something doesn't make sense? You have an excellent idea? Open an issue, but please, **don't** submit PRs. This project is curently developed as a part of software team project at [the Faculty of Information Technology, CTU](https://fit.cvut.cz/en), so we will not accept your PRs.

## Getting Started

The project has been written in Dart with AngularDart and Flutter frameworks. This makes project setup very simple. This project contains from 3 separate sub-projects—for common shared stings, AngularDart and Flutter.

For either AngularDart and Flutter you need [the Dart SDK & package manager](https://www.dartlang.org/guides/get-started) and you have to download dependencies in the bussiness logic project (`logic/`) using `pub get` command.

**Make sure you have Dart 2 installed (dev channel).**

### [AngularDart](angular)

To set up AngularDart project, you have to move into `angular/` directory and run `pub get` command to download all dependencies.

To run the project, you can simply use the `pub run build_runner serve` command. For more options on how to run the project, check the [Angular README](angular).

### [Flutter](flutter)

To set up Flutter project, you will need some prerequisites, i.e. [the Flutter SDK](https://flutter.io/setup)—for running the mobile app—and [the Android emulator](https://developer.android.com/studio/index.html), iOS emulator or a physical mobile device. Make sure you are all good with Flutter using the `flutter doctor` command.

To run the project, you can simply use the `flutter run` command.

## [Changelog](CHANGELOG.md)

## License

Licensed under the [MIT License](LICENSE).
