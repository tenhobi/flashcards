import 'package:flashcards_common/src/i18n/generated/messages_all.dart';

void initLocales(List<String> locales) {
  //todo: return loading status and load one locale at time
  locales.forEach(initializeMessages);
}
