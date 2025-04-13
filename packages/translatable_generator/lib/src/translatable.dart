sealed class TranslatableJSONProperty {
  final String fieldName;
  const TranslatableJSONProperty({required this.fieldName});
}

class TranslatableJSONPropertyString extends TranslatableJSONProperty {
  const TranslatableJSONPropertyString({required super.fieldName});
}

class TranslatableNestedJSONObject extends TranslatableJSONProperty {
  final List<TranslatableJSONProperty> properties;
  const TranslatableNestedJSONObject({required super.fieldName, required this.properties});
}

class TranslatableNestedStringList extends TranslatableJSONProperty {
  const TranslatableNestedStringList({required super.fieldName});
}

class TranslatableNestedObjectList extends TranslatableJSONProperty {
  final List<TranslatableJSONProperty> properties;
  const TranslatableNestedObjectList({required super.fieldName, required this.properties});
}

abstract interface class TranslatableInterface {
  List<TranslatableJSONProperty> get translatableJSONProperties;

  Map<String, dynamic> toJson();

  TranslatableInterface fromJson(Map<String, dynamic> json);
}
