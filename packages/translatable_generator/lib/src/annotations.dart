class Translatable {
  final bool makeFieldsTranslatableByDefault;
  const Translatable({this.makeFieldsTranslatableByDefault = true});
}

class TranslatableField {
  const TranslatableField();
}

class NonTranslatableField {
  const NonTranslatableField();
}

class AllFieldsTranslatable {
  const AllFieldsTranslatable();
}

const translatable = Translatable();

const translatableField = TranslatableField();

const nonTranslatableField = NonTranslatableField();

const allFieldsTranslatable = AllFieldsTranslatable();
