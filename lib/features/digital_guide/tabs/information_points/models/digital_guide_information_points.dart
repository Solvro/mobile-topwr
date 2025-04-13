import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

import "../../../../../l10n/app_localizations.dart";

part "digital_guide_information_points.freezed.dart";
part "digital_guide_information_points.g.dart";
part "digital_guide_information_points.translatable.g.dart";

@freezed
@translatable
abstract class DigitalGuideInformationPoint
    with _$DigitalGuideInformationPoint, _$DigitalGuideInformationPointTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DigitalGuideInformationPoint({
    required int id,
    required DigitalGuideInformationPointTranslations translations,
    required int orderNumber,
    required String isMarked,
    required String isVisibleFromAfar,
    required String areAccessBarriers,
    required String areSeatsAvailable,
    required String isMovementSpace,
    required String isGoodLit,
    required int counterHeight,
    required String isSpaceUnderCounter,
    required String isSpaceOnCounter,
    required String hasInductionLoop,
    required String? hasSoundTransmitter,
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
      l10n.is_marked(isMarked.toLowerCase()),
      l10n.are_seats_available(areSeatsAvailable.toLowerCase()),
      l10n.is_space_on_counter(isSpaceOnCounter.toLowerCase()),
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
