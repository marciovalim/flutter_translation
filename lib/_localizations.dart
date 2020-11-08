import 'package:flutter/widgets.dart';

import './_language_entity.dart';
import '_translator.dart';

abstract class ILocalizations<TranslatorType extends ITranslator> {
  TranslatorType translator;
  Locale locale;

  ILocalizations(this.locale) {
    translator = getTranslator(locale.languageCode);
  }

  TranslatorType getTranslator(String languageCode);
}

abstract class ILocalizationsDelegate<LocalizationType extends ILocalizations>
    extends LocalizationsDelegate<LocalizationType> {
  const ILocalizationsDelegate();

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) {
    return getLanguages().any((lang) => lang.code == locale.languageCode);
  }

  List<LanguageEntity> getLanguages();
}
