import 'package:flutter/material.dart';
import 'package:flutter_translation/flutter_translation.dart';

import '../dependency_injection/getIt.dart';
import './app_languages.dart';
import './app_translator.dart';

class AppLocalizations extends ILocalizations<AppTranslator> {
  AppLocalizations.singleton(Locale locale) : super(locale);

  @override
  AppTranslator getTranslator(String languageCode) {
    return getIt<AppLanguages>().findByCode(languageCode).translator;
  }
}

class AppLocalizationsDelegate
    extends ILocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  List<LanguageEntity> getLanguages() =>
      getIt<AppLanguages>().languages; // something like: getIt().languages;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations.singleton(locale);
  }
}
