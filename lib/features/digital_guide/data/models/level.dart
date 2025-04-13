import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "level.freezed.dart";
part "level.g.dart";
part "level.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class Level with _$Level, _$LevelTranslatable {
  const factory Level({
    required int id,
    @JsonKey(name: "floor_number") required int floorNumber,
    required LevelTranslations translations,
    @JsonKey(name: "regions") required List<int> regionIndices,
  }) = _Level;

  const Level._();

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
}

@freezed
abstract class LevelTranslations with _$LevelTranslations {
  const factory LevelTranslations({@JsonKey(name: "pl") required LevelTranslation plTranslation}) = _LevelTranslations;

  factory LevelTranslations.fromJson(Map<String, dynamic> json) => _$LevelTranslationsFromJson(json);
}

@freezed
abstract class LevelTranslation with _$LevelTranslation {
  const factory LevelTranslation({
    required String name,
    @JsonKey(name: "room_numbers_range") required String roomNumbersRange,
  }) = _LevelTranslation;

  factory LevelTranslation.fromJson(Map<String, dynamic> json) => _$LevelTranslationFromJson(json);
}
