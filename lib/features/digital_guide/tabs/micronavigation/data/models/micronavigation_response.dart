// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "micronavigation_response.freezed.dart";
part "micronavigation_response.g.dart";
part "micronavigation_response.translatable.g.dart";

@freezed
@translatable
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
  const factory MicronavigationTranslations({String? pl, String? en, String? nb, String? de, String? uk}) =
      _MicronavigationTranslations;

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
