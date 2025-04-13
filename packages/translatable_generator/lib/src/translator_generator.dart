import "package:analyzer/dart/element/element.dart";
import "package:analyzer/dart/element/type.dart";
import "package:build/build.dart";
import "package:json_annotation/json_annotation.dart" show FieldRename, JsonKey, JsonSerializable;
import "package:source_gen/source_gen.dart";

import "annotations.dart";

class TranslatableGenerator extends GeneratorForAnnotation<Translatable> {
  static final filenamePartOfAlreadyExists = <String>{};

  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError("Translatable annotation can only be applied to classes.", element: element);
    }

    final buffer = StringBuffer();
    final className = element.name;
    final mixinName = "_\$${className}Translatable";

    final fullFilePath = element.source.uri.pathSegments.join("/");
    if (!filenamePartOfAlreadyExists.contains(fullFilePath)) {
      buffer.writeln("part of '${element.source.uri.pathSegments.last}';");
      filenamePartOfAlreadyExists.add(fullFilePath);
    }
    buffer.writeln("mixin $mixinName implements TranslatableInterface {");
    buffer.writeln("  @override");
    buffer.writeln("  List<TranslatableJSONProperty> get translatableJSONProperties => [");

    final makeFieldsTranslatableByDefault = annotation.read("makeFieldsTranslatableByDefault").boolValue;

    final factoryConstructor = _findFreezedFactoryConstructor(element);

    if (factoryConstructor == null) {
      throw InvalidGenerationSourceError(
        "No freezed `fromJson` factory constructor found for class $className",
        element: element,
      );
    }

    final fieldRename = _getFieldRenameFromAnnotation(factoryConstructor);

    for (final parameter in factoryConstructor.parameters) {
      if (_shouldGenerateForParameter(parameter, makeFieldsTranslatableByDefault)) {
        _generatePropertyForParameter(buffer, parameter, "    ", makeFieldsTranslatableByDefault, fieldRename);
      }
    }

    buffer.writeln("  ];");
    buffer.writeln();
    buffer.writeln("  @override");
    buffer.writeln("  $className fromJson(Map<String, dynamic> json) => $className.fromJson(json);");
    buffer.writeln();
    buffer.writeln("}");
    return buffer.toString();
  }

  ConstructorElement? _findFreezedFactoryConstructor(ClassElement classElement) {
    // Look for the main factory constructor that Freezed uses
    for (final constructor in classElement.constructors) {
      if (constructor.isFactory && !constructor.name.contains("fromJson")) {
        return constructor;
      }
    }
    return null;
  }

  bool _shouldGenerateForParameter(ParameterElement parameter, bool defaultTranslatable) {
    // Skip private fields
    if (parameter.name.startsWith("_")) return false;

    // Check for explicit annotations
    final isExplicitlyTranslatable = const TypeChecker.fromRuntime(TranslatableField).hasAnnotationOf(parameter);

    final isExplicitlyNonTranslatable = const TypeChecker.fromRuntime(NonTranslatableField).hasAnnotationOf(parameter);

    if (isExplicitlyTranslatable) return true;
    if (isExplicitlyNonTranslatable) return false;

    // Use the default
    return defaultTranslatable;
  }

  FieldRename? _getFieldRenameFromAnnotation(ConstructorElement factoryConstructor) {
    // Check for JsonSerializable annotation and its fieldRename parameter
    final jsonSerializable = const TypeChecker.fromRuntime(JsonSerializable).firstAnnotationOf(factoryConstructor);
    FieldRename? fieldRename;
    if (jsonSerializable != null) {
      final fieldRenameObj = jsonSerializable.getField("fieldRename");
      if (fieldRenameObj != null) {
        fieldRename = FieldRename.values[fieldRenameObj.getField("index")!.toIntValue()!];
      }
    }

    return fieldRename;
  }

  void _generatePropertyForParameter(
    StringBuffer buffer,
    ParameterElement parameter,
    String indent,
    bool makeFieldsTranslatableByDefault,
    FieldRename? fieldRename,
  ) {
    if (fieldRename != null && fieldRename != FieldRename.snake) {
      throw InvalidGenerationSourceError("FieldRename other than snake is not supported yet", element: parameter);
    }

    final isSnakeRenamed = fieldRename == FieldRename.snake;

    final fieldName =
        const TypeChecker.fromRuntime(JsonKey).firstAnnotationOf(parameter)?.getField("name")?.toStringValue() ??
        (!isSnakeRenamed ? parameter.name : _snakeCase(parameter.name));

    final fieldType = parameter.type;

    if (_isStringType(fieldType)) {
      buffer.writeln("${indent}TranslatableJSONPropertyString(fieldName: '$fieldName'),");
    } else if (_isListType(fieldType)) {
      final listType = _getListGenericType(fieldType);
      if (listType != null && listType is InterfaceType) {
        if (_isStringType(listType)) {
          buffer.writeln("${indent}TranslatableNestedStringList(fieldName: '$fieldName'),");
        } else if (_isJsonSerializableOrFreezed(listType)) {
          buffer.writeln("${indent}TranslatableNestedObjectList(");
          buffer.writeln("$indent  fieldName: '$fieldName',");

          // Generate the list of translatable properties directly
          buffer.writeln("$indent  properties: [");
          _generateNestedTranslatableProperties(
            buffer,
            listType,
            "$indent    ",
            <String>{},
            makeFieldsTranslatableByDefault,
          );
          buffer.writeln("$indent  ],");

          buffer.writeln("$indent),");
        }
      }
    } else if (_isJsonSerializableOrFreezed(fieldType)) {
      buffer.writeln("${indent}TranslatableNestedJSONObject(");
      buffer.writeln("$indent  fieldName: '$fieldName',");

      // Generate the list of translatable properties directly
      buffer.writeln("$indent  properties: [");
      _generateNestedTranslatableProperties(
        buffer,
        fieldType as InterfaceType,
        "$indent    ",
        <String>{},
        makeFieldsTranslatableByDefault,
      );
      buffer.writeln("$indent  ],");

      buffer.writeln("$indent),");
    }
  }

  /// Generates all translatable properties for a type at compile time
  void _generateNestedTranslatableProperties(
    StringBuffer buffer,
    InterfaceType type,
    String indent,
    Set<String> visitedTypes,
    bool makeFieldsTranslatableByDefault,
  ) {
    final typeName = type.getDisplayString();

    // Prevent infinite recursion for circular references
    if (visitedTypes.contains(typeName)) {
      buffer.writeln("$indent// Skipping recursive reference to $typeName");
      return;
    }

    // Add current type to visited set
    visitedTypes.add(typeName);

    // Find the constructor with the parameters we want to process
    final classElement = type.element as ClassElement;
    final factoryConstructor = _findFreezedFactoryConstructor(classElement);

    // Check if the class has @Translatable annotation and get its makeFieldsTranslatableByDefault value
    final classAnnotation = const TypeChecker.fromRuntime(Translatable).firstAnnotationOf(classElement);
    final classDefaultTranslatable = classAnnotation?.getField("makeFieldsTranslatableByDefault")?.toBoolValue();

    // Use class annotation value if present, otherwise use passed parameter
    final effectiveMakeFieldsTranslatable = classDefaultTranslatable ?? makeFieldsTranslatableByDefault;

    if (factoryConstructor == null) {
      throw InvalidGenerationSourceError(
        "No freezed `fromJson` factory constructor found for class $typeName",
        element: type.element,
      );
    }

    final fieldRename = _getFieldRenameFromAnnotation(factoryConstructor);

    for (final parameter in factoryConstructor.parameters) {
      if (_shouldGenerateForParameter(parameter, effectiveMakeFieldsTranslatable)) {
        _generatePropertyForParameter(buffer, parameter, indent, effectiveMakeFieldsTranslatable, fieldRename);
      }
    }

    // Remove the type from visited set as we're done processing it
    visitedTypes.remove(typeName);
  }

  bool _isStringType(DartType type) {
    return type.isDartCoreString;
  }

  bool _isListType(DartType type) {
    return type.isDartCoreList || type.toString().contains("IList");
  }

  DartType? _getListGenericType(DartType type) {
    if (type is InterfaceType && _isListType(type)) {
      if (type.typeArguments.isNotEmpty) {
        return type.typeArguments.first;
      }
    }
    return null;
  }

  bool _isJsonSerializableOrFreezed(DartType type) {
    if (type is! InterfaceType) {
      return false;
    }

    final element = type.element;
    if (element is! ClassElement) {
      return false;
    }

    // Check if the class has a fromJson factory constructor (additional check for json serializable)
    final hasFromJsonFactory = element.constructors.any(
      (constructor) => constructor.isFactory && constructor.name == "fromJson",
    );

    return hasFromJsonFactory;
  }
}

String _snakeCase(String name) {
  return name.replaceAllMapped(RegExp("(?<=[a-z])[A-Z]"), (Match match) => "_${match.group(0)}").toLowerCase();
}
