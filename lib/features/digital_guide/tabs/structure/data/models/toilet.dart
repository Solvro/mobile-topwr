import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "toilet.freezed.dart";
part "toilet.g.dart";

@freezed
abstract class Toilet with _$Toilet {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Toilet({
    required ToiletTranslations translations,
    @JsonKey(name: "is_available_for", fromJson: getToiletType) required ToiletType toiletType,
    required String isNeedAuthorization,
    required String isWastebasket,
    required String areClothesHooks,
    required String isHandDryer,
    required String isTowelDispenser,
    required String isWashbasin,
    required String isSpaceUnderWashbasinForWheelchair,
    required String isLightSwitch,
    required String isGoodLit,
    required String isGoodDevicesWallContrast,
    @JsonKey(name: "doors") required IList<int> doorsIds,
  }) = _Toilet;

  factory Toilet.fromJson(Map<String, dynamic> json) => _$ToiletFromJson(json);
}

@freezed
abstract class ToiletTranslations with _$ToiletTranslations {
  const factory ToiletTranslations({@JsonKey(name: "pl") required ToiletTranslation plTranslation}) =
      _ToiletTranslations;

  factory ToiletTranslations.fromJson(Map<String, dynamic> json) => _$ToiletTranslationsFromJson(json);
}

@freezed
abstract class ToiletTranslation with _$ToiletTranslation {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ToiletTranslation({
    required String location,
    required String numberOfCabins,
    required String toiletDescription,
    required String isNeedAuthorizationComment,
    required String isWastebasketComment,
    required String areClothesHooksComment,
    required String isHandDryerComment,
    required String isTowelDispenserComment,
    required String isWashbasinComment,
    required String isSpaceUnderWashbasinForWheelchairComment,
    required String isLightSwitchComment,
    required String isGoodLitComment,
    required String isGoodDevicesWallContrastComment,
    required String comment,
  }) = _ToiletTranslation;

  factory ToiletTranslation.fromJson(Map<String, dynamic> json) => _$ToiletTranslationFromJson(json);
}

enum ToiletType { men, women }

ToiletType getToiletType(String option) {
  return option == "1" ? ToiletType.men : ToiletType.women;
}
