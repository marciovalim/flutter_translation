# Flutter Translation

A package that helps eliminate boilerplate code when implementing translations in Flutter.

## Getting Started

Add to pubspec.yaml:

```yaml
dependencies:
  flutter_translation: ^0.0.5
  flutter_localizations:  
      sdk: flutter
```

Create the translator classes: ``app_translator.dart``

```dart
abstract class AppTranslator extends ITranslator {
  const AppTranslator();

  String get title;
}

class PtTranslator extends AppTranslator {
  String get title => 'Título';
}
class EnTranslator extends AppTranslator {
  String get title => 'Title';
}
```

Create the AppLanguages class: ``app_languages.dart``

```dart
class AppLanguages extends ILanguages {
  AppLanguages.singleton();

  @override
  LanguageEntity get defaultLanguage =>
      languages.firstWhere((lang) => lang.code == 'en');

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
```

You will need to create a singleton from AppLanguages. I'll use getIt to do that. <br>
Getting started with <a href="https://pub.dev/packages/get_it" target="blank">get_it</a>. <br>
In you getIt setup:

```dart
  getIt.registerSingleton<AppLanguages>(AppLanguages.singleton());
```

Create the localization, and the delegate classes: ``app_localizations.dart``

```dart
class AppLocalizations extends ILocalizations<AppTranslator> {
  AppLocalizations.singleton(Locale locale) : super(locale);

  @override
  AppTranslator getTranslator(String languageCode) {
    throw UnimplementedError();
    // something like: getIt<AppLanguages>().findByCode(languageCode).translator
  }
}
  
class AppLocalizationsDelegate
    extends ILocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  // here is where we need dependency injection
  List<LanguageEntity> getLanguages() => throw UnimplementedError(); // something like: getIt<AppLanguages>().languages;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations.singleton(locale); // create AppLocalizations instance
  }
}
```

Your setup is done! <br>
Now you just need to start using it, like so:


```dart
import 'package:flutter_translation/flutter_translation.dart';

return MaterialApp(
  supportedLocales: getIt<AppLanguages>()
                  .languages
                  .map((lang) => lang.toLocale()),
  locale: getIt<AppLanguages>().defaultLanguage.toLocale(),
  localizationsDelegates: [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate, 
    GlobalWidgetsLocalizations.delegate, 
  ],
);
```


And then use to translate what you want:

```dart
  final translator = getIt.get<AppTranslator>(param1: context);
  return Scaffold(
    body: Center(
      child: Text(translator.title),
    ),
  );
```


Note: I'm using getIt to deal with dependency injection, but you can use whatever you prefer to do this. <br>
If you want to use getIt like me, add this to your getIt setup function:

```dart
getIt.registerFactoryParam<AppTranslator, BuildContext, Object>(
  (context, nullParam) =>
      Localizations.of(context, AppLocalizations).translator,
);
```

or simply

```dart
void findTranslator(BuildContext context){
  return Localizations.of(context, AppLocalizations).translator;
}
```

Congratulations! You've added translation support to your app. <br>
You can scale the languages and the strings as you need. <br>
You can also manage the current language state to switch between languages. <br>

If you found this implementation too big, remember that without this package it would be even bigger 😜.
Don't forget to star if you liked 😉.
