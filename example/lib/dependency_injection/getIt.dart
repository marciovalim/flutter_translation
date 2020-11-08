import 'package:example/language_bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../translation/app_languages.dart';
import '../translation/app_translator.dart';
import '../translation/app_localizations.dart';

final getIt = GetIt.instance;

class AppGetIt {
  AppGetIt._();

  static void init() {
    getIt.registerSingleton<AppLanguages>(AppLanguages.singleton());
    getIt.registerFactoryParam<AppTranslator, BuildContext, Object>(
      (context, nullParam) =>
          Localizations.of(context, AppLocalizations).translator,
    );
    getIt.registerSingleton<LanguageBloc>(LanguageBloc());
  }
}
