// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../../../utils/type_converter.dart";

part "micronavigation_response.freezed.dart";
part "micronavigation_response.g.dart";
part "micronavigation_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
// TODO(simon-the-shark): this needs custom translations
abstract class MicronavigationResponse with _$MicronavigationResponse, _$MicronavigationResponseTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MicronavigationResponse({
    required int id,
    required int location,
    required MicronavigationTranslations nameOverride,
    required MicronavigationTranslations webContent,
    required List<MicronavigationLanguage> languages,
  }) = _MicronavigationResponse;

  const MicronavigationResponse._();

  factory MicronavigationResponse.fromJson(Map<String, dynamic> json) => _$MicronavigationResponseFromJson(json);
}

@freezed
abstract class MicronavigationTranslations with _$MicronavigationTranslations {
  const factory MicronavigationTranslations({
    @JsonKey(fromJson: emptyStringToNull) String? pl,
    @JsonKey(fromJson: emptyStringToNull) String? en,
    @JsonKey(fromJson: emptyStringToNull) String? nb,
    @JsonKey(fromJson: emptyStringToNull) String? de,
    @JsonKey(fromJson: emptyStringToNull) String? uk,
  }) = _MicronavigationTranslations;

  factory MicronavigationTranslations.fromJson(Map<String, dynamic> json) =>
      _$MicronavigationTranslationsFromJson(json);
}

@freezed
abstract class MicronavigationLanguage with _$MicronavigationLanguage {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MicronavigationLanguage({
    required int id,
    required String langCode,
    String? text,
    String? sound,
    required int order,
  }) = _MicronavigationLanguage;

  factory MicronavigationLanguage.fromJson(Map<String, dynamic> json) => _$MicronavigationLanguageFromJson(json);
}
