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

  static m0(count) => "${Intl.plural(count, zero: 'beta 0 ${count}', one: 'gama 1', two: 'delta 2', other: 'zeta 3')}";

  static m1(howMany, userName) =>
      "${Intl.plural(howMany, zero: 'There are no emails left for ${userName}.', one: 'There is ${howMany} email left for ${userName}.', other: 'There are ${howMany} emails left for ${userName}.')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "descriptionTab": MessageLookupByLibrary.simpleMessage("Popis"),
        "hovno": m0,
        "loginButton": MessageLookupByLibrary.simpleMessage("Přihlásit se pomocí Google"),
        "remainingEmailsMessage": m1,
        "sectionsTab": MessageLookupByLibrary.simpleMessage("Sekce"),
        "signInButton": MessageLookupByLibrary.simpleMessage("zaregistrovat se")
      };
}
