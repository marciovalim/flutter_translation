import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translation/flutter_translation.dart';

import 'package:example/dependency_injection/getIt.dart';
import 'package:example/translation/app_languages.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(LanguageChangedState(
            getIt<AppLanguages>().defaultLanguage.toLocale()));

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is LanguageChangeEvent) {
      yield LanguageChangedState(Locale(event.languageCode));
    }
  }
}
