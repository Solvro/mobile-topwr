import "../index.dart";

Future<List<String>> translateList<T extends SolvroTranslator>(
  List<String> value,
  T translator,
  SolvroLocale locale,
) async {
  return Future.wait(value.map((value) => translator.translate(value, locale)));
}

Future<void> _translateProperty<T extends TranslatableInterface, Translator extends SolvroTranslator>(
  Map<String, dynamic> json,
  TranslatableJSONProperty property,
  Translator translator,
  SolvroLocale locale,
) async {
  switch (property) {
    case TranslatableJSONPropertyString(:final fieldName):
      json[fieldName] = await translator.translate(json[fieldName] as String, locale);
    case TranslatableNestedStringList(:final fieldName):
      json[fieldName] = await translateList(json[fieldName] as List<String>, translator, locale);
    case TranslatableNestedJSONObject(:final properties, :final fieldName):
      await _translateMultProperties(json[fieldName] as Map<String, dynamic>, properties, translator, locale);
    case TranslatableNestedObjectList(:final properties, :final fieldName):
      final list = json[fieldName] as List<Map<String, dynamic>>;
      await Future.wait(list.map((item) => _translateMultProperties(item, properties, translator, locale)));
  }
}

Future<void> _translateMultProperties<T extends TranslatableInterface, Translator extends SolvroTranslator>(
  Map<String, dynamic> json,
  List<TranslatableJSONProperty> properties,
  Translator translator,
  SolvroLocale locale,
) async {
  await Future.wait(properties.map((property) => _translateProperty(json, property, translator, locale)));
}

extension TranslateX<T extends TranslatableInterface, Translator extends SolvroTranslator> on T {
  Future<T> translate(Translator translator, SolvroLocale locale) async {
    if (locale == SolvroLocale.pl) {
      return this;
    }

    final json = toJson();
    await _translateMultProperties(json, translatableJSONProperties, translator, locale);
    return fromJson(json) as T;
  }
}
