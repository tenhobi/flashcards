import 'package:intl/intl.dart';
import 'package:flashcards_common/src/i18n/generated/messages_all.dart';

void initLocales(List<String> locales) {
  //todo: return loading status and load one locale at time
  locales.forEach((l) {initializeMessages(l);});
}

class FlashcardsStrings {
  static String loginButton() {
    return Intl.message(
      '_loginButton',
      name: 'loginButton',
      desc: 'Login button on landing screen',
    );
  }

  static String signInButton() {
    return Intl.message(
      '_signInButton',
      name: 'signInButton',
      desc: 'Button sign in description',
    );
  }

  static String remainingEmailsMessage(int howMany, String userName) => Intl.plural(
        howMany,
        zero: 'There are no emails left for $userName.',
        one: 'There is $howMany email left for $userName.',
        other: 'There are $howMany emails left for $userName.',
        name: "remainingEmailsMessage",
        args: [howMany, userName],
        desc: "How many emails remain after archiving.",
        examples: const {'howMany': 42, 'userName': 'Fred'},
      );

  static String hovno(int count) => Intl.plural(
        count,
        args: [count],
        name: 'hovno',
        desc: 'alfa info',
        zero: 'beta 0 $count',
        one: 'gama 1',
        two: 'delta 2',
        other: 'zeta 3',
        examples: const {
          'count': 42,
        },
      );
}
