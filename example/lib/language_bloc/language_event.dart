part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class LanguageChangeEvent extends LanguageEvent {
  final String languageCode;

  LanguageChangeEvent(this.languageCode);
}
