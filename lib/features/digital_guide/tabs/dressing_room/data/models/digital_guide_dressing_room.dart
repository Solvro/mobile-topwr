import "package:freezed_annotation/freezed_annotation.dart";
import "package:translatable_generator/index.dart";

part "digital_guide_dressing_room.freezed.dart";
part "digital_guide_dressing_room.g.dart";
part "digital_guide_dressing_room.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DigitalGuideDressingRoom with _$DigitalGuideDressingRoom, _$DigitalGuideDressingRoomTranslatable {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideDressingRoom({
    required int id,
    required String isMarked,
    required String isVisibleFromAfar,
    required String areAccessBarriers,
    required String areSeatsAvailable,
    required String isMovementSpace,
    required String isGoodLit,
    required double counterHeight,
    required String isSpaceUnderCounter,
    required String isSpaceOnCounter,
    @translatableField required DigitalGuideTranslationsDressingRoom translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
  }) = _DigitalGuideDressingRoom;

  const DigitalGuideDressingRoom._();

  factory DigitalGuideDressingRoom.fromJson(Map<String, dynamic> json) => _$DigitalGuideDressingRoomFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationsDressingRoom with _$DigitalGuideTranslationsDressingRoom {
  const factory DigitalGuideTranslationsDressingRoom({
    @translatableField required DigitalGuideTranslationDressingRoom pl,
  }) = _DigitalGuideTranslationsDressingRoom;

  factory DigitalGuideTranslationsDressingRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsDressingRoomFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationDressingRoom with _$DigitalGuideTranslationDressingRoom {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationDressingRoom({
    @translatableField required String location,
    @translatableField required String workingDaysAndHours,
    @translatableField required String comment,
    required String isMarkedComment,
    required String isVisibleFromAfarComment,
    required String areAccessBarriersComment,
    required String areSeatsAvailableComment,
    required String isMovementSpaceComment,
    required String isGoodLitComment,
    required String isSpaceUnderCounterComment,
    required String isSpaceOnCounterComment,
  }) = _DigitalGuideTranslationDressingRoom;
  factory DigitalGuideTranslationDressingRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationDressingRoomFromJson(json);
}
