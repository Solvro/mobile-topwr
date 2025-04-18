import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

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
@allFieldsTranslatable
abstract class DigitalGuideTranslationsDressingRoom with _$DigitalGuideTranslationsDressingRoom {
  const factory DigitalGuideTranslationsDressingRoom({required DigitalGuideTranslationDressingRoom pl}) =
      _DigitalGuideTranslationsDressingRoom;

  factory DigitalGuideTranslationsDressingRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideTranslationsDressingRoomFromJson(json);
}

@freezed
abstract class DigitalGuideTranslationDressingRoom with _$DigitalGuideTranslationDressingRoom {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationDressingRoom({
    required String location,
    required String workingDaysAndHours,
    required String comment,
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
