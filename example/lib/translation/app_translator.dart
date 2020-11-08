import 'package:flutter_translation/flutter_translation.dart';

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
