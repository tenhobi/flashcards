// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a cs_CZ locale. All the
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
  get localeName => 'cs_CZ';

  static m0(version) =>
      "Verze\n__${version}__\n\nOpen source projekt s cílem vytvořit multiplatformní (tj. web, android, iOS) aplikaci s výukovými kartičkami. Na náš kód se můžete podívat na [GitHubu](https://github.com/tenhobi/flashcards).\n\nProjekt začal jako součást předmětu softwarový týmový projekt na [Fakultě informačních technologií ČVUT v Praze](https://fit.cvut.cz).";

  static m1(score) => "skóre: ${score}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "aboutLicensesText":
            MessageLookupByLibrary.simpleMessage("Aplikace je vyvíjena jako open source software: [licence]()"),
        "aboutNavigationButton": MessageLookupByLibrary.simpleMessage("O aplikaci"),
        "aboutText": m0,
        "homeNavigationButton": MessageLookupByLibrary.simpleMessage("Domů"),
        "reportBugNavigationButton": MessageLookupByLibrary.simpleMessage("Nahlásit chybu"),
        "score": m1,
        "searchNavigationButton": MessageLookupByLibrary.simpleMessage("Hledat"),
        "settingsNavigationButton": MessageLookupByLibrary.simpleMessage("Nastavení"),
        "signInButton": MessageLookupByLibrary.simpleMessage("Přihlásit se"),
        "signOutNavigationButton": MessageLookupByLibrary.simpleMessage("Odhlásit se")
      };
}
