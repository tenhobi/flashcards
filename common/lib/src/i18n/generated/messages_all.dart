// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: implementation_imports
import 'package:intl/src/intl_helpers.dart';

import 'messages_cs_CZ.dart' deferred as messages_cs_cz;
import 'messages_en_US.dart' deferred as messages_en_us;

typedef LibraryLoader = Future<dynamic> Function();

Map<String, LibraryLoader> _deferredLibraries = {
  'cs_CZ': messages_cs_cz.loadLibrary,
  'en_US': messages_en_us.loadLibrary,
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case 'cs_CZ':
      return messages_cs_cz.messages;
    case 'en_US':
      return messages_en_us.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale =
      Intl.verifiedLocale(localeName, (locale) => _deferredLibraries[locale] != null, onFailure: (_) => null);
  if (availableLocale == null) {
    return Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? Future.value(false) : lib());
  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } on Exception catch (_) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
