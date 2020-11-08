import 'package:example/language_bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translation/flutter_translation.dart';

import './translation/app_languages.dart';
import './translation/app_localizations.dart';
import './dependency_injection/getIt.dart';
import './translation/app_translator.dart';

void main() {
  AppGetIt.init();
  runApp(TranslationExampleApp());
}

class TranslationExampleApp extends StatefulWidget {
  const TranslationExampleApp({Key key}) : super(key: key);

  @override
  _TranslationExampleAppState createState() => _TranslationExampleAppState();
}

class _TranslationExampleAppState extends State<TranslationExampleApp> {
  LanguageBloc _languageBloc;

  @override
  void initState() {
    super.initState();
    _languageBloc = getIt<LanguageBloc>();
  }

  @override
  void dispose() {
    _languageBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _languageBloc,
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            supportedLocales:
                getIt<AppLanguages>().languages.map((lang) => lang.toLocale()),
            locale: state.locale,
            localizationsDelegates: [
              AppLocalizationsDelegate(),
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            home: Home(),
          );
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(getIt.get<AppTranslator>(param1: context).title),
            SizedBox(
              width: 200,
              child: ExpansionTile(
                title: Text('Languages'),
                children: getIt<AppLanguages>().languages.map((lang) {
                  return Container(
                    height: 50,
                    child: InkWell(
                      onTap: () => BlocProvider.of<LanguageBloc>(context)
                          .add(LanguageChangeEvent(lang.code)),
                      child: Center(child: Text(lang.name)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
