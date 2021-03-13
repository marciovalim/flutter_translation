import 'package:flutter/widgets.dart';

import '_translator.dart';

class LanguageEntity {
  final String code;
  final String name;
  final ITranslator translator;

  const LanguageEntity({
    required this.code,
    required this.name,
    required this.translator,
  });
}

extension LanguageEntityExtension on LanguageEntity {
  Locale toLocale() => Locale(this.code);
}
