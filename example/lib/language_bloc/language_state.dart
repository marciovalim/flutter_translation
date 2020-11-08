part of 'language_bloc.dart';

@immutable
abstract class LanguageState {
  final Locale locale;

  LanguageState(this.locale);
}

class LanguageChangedState extends LanguageState {
  LanguageChangedState(Locale locale) : super(locale);
}
