import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../../l10n/app_localizations.dart";
import "../../../../../utils/type_converter.dart";

part "digital_guide_information_points.freezed.dart";
part "digital_guide_information_points.g.dart";

@freezed
abstract class DigitalGuideInformationPoint with _$DigitalGuideInformationPoint {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DigitalGuideInformationPoint({
    required int id,
    required DigitalGuideInformationPointTranslations translations,
    required int orderNumber,
    @JsonKey(fromJson: stringToBool) required bool isMarked,
    @JsonKey(fromJson: stringToBool) required bool isVisibleFromAfar,
    @JsonKey(fromJson: stringToBool) required bool areAccessBarriers,
    @JsonKey(fromJson: stringToBool) required bool areSeatsAvailable,
    @JsonKey(fromJson: stringToBool) required bool isMovementSpace,
    @JsonKey(fromJson: stringToBool) required bool isGoodLit,
    required int counterHeight,
    @JsonKey(fromJson: stringToBool) required bool isSpaceUnderCounter,
    @JsonKey(fromJson: stringToBool) required bool isSpaceOnCounter,
    @JsonKey(fromJson: stringToBool) required bool hasInductionLoop,
    @JsonKey(fromJson: stringToBool) required bool hasSoundTransmitter,
    required int building,
    required List<dynamic> rings,
    required List<dynamic> images,
  }) = _DigitalGuideInformationPoint;

  const DigitalGuideInformationPoint._();

  factory DigitalGuideInformationPoint.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideInformationPointFromJson(json);

  IList<String> getBulletList(AppLocalizations l10n) {
    final pl = translations.pl;
    return [
      pl.location,
      if (isMarked) l10n.isMarked,
      if (areSeatsAvailable) l10n.are_seats_available,
      if (isSpaceOnCounter) l10n.is_space_on_counter,
      pl.workingDaysAndHours,
    ].lock;
  }
}

@freezed
abstract class DigitalGuideInformationPointTranslations with _$DigitalGuideInformationPointTranslations {
  factory DigitalGuideInformationPointTranslations({required DigitalGuideInformationPointTranslationDetails pl}) =
      _DigitalGuideInformationPointTranslations;

  factory DigitalGuideInformationPointTranslations.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideInformationPointTranslationsFromJson(json);
}

@freezed
abstract class DigitalGuideInformationPointTranslationDetails with _$DigitalGuideInformationPointTranslationDetails {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DigitalGuideInformationPointTranslationDetails({
    required String location,
    required String isMarkedComment,
    required String isVisibleFromAfarComment,
    required String areAccessBarriersComment,
    required String areSeatsAvailableComment,
    required String isMovementSpaceComment,
    required String isGoodLitComment,
    required String isSpaceUnderCounterComment,
    required String isSpaceOnCounterComment,
    required String hasInductionLoopComment,
    required String workingDaysAndHours,
    required String comment,
  }) = _DigitalGuideInformationPointTranslationDetails;

  factory DigitalGuideInformationPointTranslationDetails.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideInformationPointTranslationDetailsFromJson(json);
}
