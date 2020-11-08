# Flutter Translation

A package that helps eliminate boilerplate code when implementing translations in Flutter.

## Getting Started

Add to pubspec.yaml:

<pre>
dependencies:
  flutter_translation: ^0.0.5
  flutter_localizations:  
      sdk: flutter
</pre>

Create the translator classes: (app_translator.dart)

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

Create the AppLanguages class: (app_languages.dart)

<pre>
class AppLanguages extends ILanguages {
  AppLanguages.singleton();

  @override
  LanguageEntity get defaultLanguage =>
      languages.firstWhere((lang) => lang.code == 'en');

  @override
  List&ltLanguageEntity&gt createLanguages() {
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

You will need to create a singleton from AppLanguages. I'll use getIt to do that. <br>
Getting started with <a href="https://pub.dev/packages/get_it" target="blank">get_it</a>. <br>
In you getIt setup:

<pre>
  getIt.registerSingleton&ltAppLanguages&gt(AppLanguages.singleton());
</pre>

Create the localization and the delegate classes: (app_localizations.dart)

<pre>
class AppLocalizations extends ILocalizations&ltAppTranslator&gt {
  AppLocalizations.singleton(Locale locale) : super(locale);

  @override
  AppTranslator getTranslator(String languageCode) {
    throw UnimplementedError();
    // something like: getIt&ltAppLanguages&gt().findByCode(languageCode).translator
  }
}
  
class AppLocalizationsDelegate
    extends ILocalizationsDelegate&ltAppLocalizations&gt {
  const AppLocalizationsDelegate();

  @override
  // here is where we need dependency injection
  List&ltLanguageEntity&gt getLanguages() => throw UnimplementedError(); // something like: getIt&ltAppLanguages&gt().languages;

  @override
  Future&ltAppLocalizations&gt load(Locale locale) async {
    return AppLocalizations.singleton(locale); // create AppLocalizations instance
  }
}
</pre>

Your setup is done! <br>
Now you just need to start using it, like so:

<pre>
import 'package:flutter_translation/flutter_translation.dart';

return MaterialApp(
  supportedLocales: getIt&ltAppLanguages&gt()
                  .languages
                  .map((lang) => lang.toLocale()),
  locale: getIt&ltAppLanguages&gt().defaultLanguage.toLocale(),
  localizationsDelegates: [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate, 
    GlobalWidgetsLocalizations.delegate, 
  ],
);
</pre>

And then use to translate what you want:

<pre>
  final translator = getIt.get&ltAppTranslator&gt(param1: context);
  return Scaffold(
    body: Center(
      child: Text(translator.title),
    ),
  );
</pre>

Note: I'm using getIt to deal with dependency injection, but you can use whatever you prefer to do this. <br>
If you want to use getIt like me, add this to your getIt setup function:

<pre>
getIt.registerFactoryParam&ltAppTranslator, BuildContext, Object&gt(
  (context, nullParam) =>
      Localizations.of(context, AppLocalizations).translator,
);
</pre>

Congratulations! You've added translation support to your app. <br>
You can scale the languages and the strings as you need. <br>
You can also manage the current language state to switch between languages. <br>

If you found this implementation too big, remember that without this package it would be even bigger 😜.
Don't forget to star if you liked 😉.
