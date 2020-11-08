import 'package:flutter_translation/flutter_translation.dart';

import './app_translator.dart';

class AppLanguages extends ILanguages {
  AppLanguages.singleton();

  @override
  LanguageEntity get defaultLanguage =>
      languages.firstWhere((lang) => lang.code == 'pt');

  @override
  List<LanguageEntity> createLanguages() {
    return [
      LanguageEntity(
        code: 'pt',
        name: 'Português',
        translator: PtTranslator(),
      ),
      LanguageEntity(
        code: 'en',
        name: 'English',
        translator: EnTranslator(),
      ),
    ];
  }
}
