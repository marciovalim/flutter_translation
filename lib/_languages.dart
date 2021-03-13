import './_language_entity.dart';

abstract class ILanguages {
  late List<LanguageEntity> languages;

  ILanguages() {
    languages = createLanguages();
  }

  List<LanguageEntity> createLanguages();

  LanguageEntity get defaultLanguage;

  LanguageEntity findByCode(String code) =>
      languages.firstWhere((lang) => lang.code == code);

  int indexByCode(String code) =>
      languages.indexWhere((lang) => lang.code == code);
}
