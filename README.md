# Flutter Translation

A package that helps eliminate boilerplate code when implementing translations in Flutter.

## Getting Started

Add to pubspec.yaml:

<pre>
dependencies:
  flutter_translation: ^0.0.1
  flutter_localizations:  
      sdk: flutter
</pre>

Create the translator classes:

<pre>
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
</pre>

Create the localization and the delegate class:

<pre>
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
  List<LanguageEntity> getLanguages() => throw UnimplementedError(); // something like: getIt<AppLanguages>().languages;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations.singleton(locale); // create AppLocalizations instance
  }
}
</pre>

Create the languages class:

<pre>
class AppLanguage extends ILanguages {
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
</pre>

Your setup is done! <br>
Now you just need to start using it, like so:

<pre>
return MaterialApp(
  supportedLocales: getIt<AppLanguages>()
                  .languages
                  .map((lang) => lang.toLocale()),
  locale: getIt<AppLanguages>().defaultLanguage,
  localizationsDelegates: [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate, 
    GlobalWidgetsLocalizations.delegate, 
  ],
);
</pre>

And then use to translate what you want:

<pre>
  final translator = getIt.get<AppTranslator>(param1: context);
  return Scaffold(
    body: Center(
      child: Text(translator.title),
    ),
  );
</pre>

Note: I'm using getIt to deal with dependency injection, but you can use whatever you prefer to do this. <br>
If you want to use getIt like me, add this to your getIt setup function:

<pre>
getIt.registerFactoryParam<AppTranslator, BuildContext, Object>(
  (context, nullParam) =>
      Localizations.of(context, AppLocalizations).translator,
);
</pre>

Congratulations! You've added translation support to your app. <br>
You can scale the languages and the strings as you need.

If you found this implementation too big, remember that without this package it would be even bigger 😜.
