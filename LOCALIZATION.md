# How to
So, you have just added some string to program, let's say it's `TextBox("Hello world.")`.
First of all, don't use simple string (`"Hello world."`), instead use `FlashcardsStrings.of(context).<name>()`.
`FlashcardsStrings` is imported class from file `FlashcardsStrings.dart`, `of(context)` is just method that returns complete dictionary based on language stored in `BuildContext context` passed as parameter and `<name>()` is name of *Template*.
Ok, so now you have `TextBox(FlashcardsStrings.of(context).HelloWorld())`, you have to add `HelloWorld()` template to `FlashcardsString.dart` file according to [Intl](https://pub.dartlang.org/packages/intl#messages) reference.
Add this to `FlashcardsString.dart` file:
```Dart
  String HelloWorld() {
    return Intl.message(
      'Hello world',
      name: 'hello_world',
      desc: 'Example text',
      locale: _localeName,
    );
  }
```
Now just look at *Method two*, run these commands and everything should work.

## Method one: I've just translated something 

### Use tool/localization.sh
Oh, you are a such a great guy, here, have some :cookie: 
Now let's get to the business. So you have just edited some of the flashcards_<lang>.arb files. 
Run in console this line (while your operating folder is root of flutter app, otherwise you will get `missing pubspec.yaml` error) and execute this command: 
 
`pub run intl_translation:generate_from_arb --output-dir=lib/src/i18n/generated --generated-file-prefix=flashcards_ lib/src/i18n/*.dart lib/src/i18n/translations/flashcards_*.arb` 
 
PS: if you've changed just one file, change `common/lib/i18n/generated/flashcards_*.arb` to `common/lib/i18n/generated/flashcards_<lang>.arb`, lang according to the file you've changed. 
 
## Method two: I've added some templates 

### Use tool/localization.sh
Then just simply run 
 
`pub run intl_translation:extract_to_arb --output-dir=lib/src/i18n lib/src/i18n/flashcards_strings.dart` 
 
And It'll generate new `intl_messages.arb` file. Now just copy changes to `flashcards_<lang>.arb`, translate it and continue on *Method one*. 


# Edit disclaimer 
Do NOT edit file `FlashcardsDelegate.dart` unless you know exactly what are you are doing. 
Do NOT edit file `FlashcardsStrings.dart` unless you know exactly what are you are doing, or you are adding new generation template (End of the `FlashcardsStrings` class). 
 
# So what it is and how to use it? 
`FlashcardsDelegate.dart` is file that is responsible for loading localizations and according files to that. 
 
`FlashcardsStrings.dart` contains class which stores all localized values. 
At the end of this class are `String` returning methods, these serves for two purposes. 
1. They act as a template while generating `.arb` files for translations. 
2. They are getters of localized strings. 
More about these methods in [Intl](https://pub.dartlang.org/packages/intl#messages) documentation. 
 
Folder `generated` contains all generated files. Do NOT edit any of these files, except `flashcards_<lang>.arb`. 
 
In file `generated/intl_messages.arb` is template, how `flashcards_<lang>.arb` should look like, except for the localized string of course. 
 
