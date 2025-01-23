import "package:freezed_annotation/freezed_annotation.dart";

part "digital_guide_dressing_room.freezed.dart";
part "digital_guide_dressing_room.g.dart";

@freezed
class DigitalGuideDressingRoom with _$DigitalGuideDressingRoom {
  const factory DigitalGuideDressingRoom({
    required int id,
    required DigitalGuideTranslationsDressingRoom translations,
    @JsonKey(name: "images") required List<int>? imagesIds,
  }) = _DigitalGuideDressingRoom;

  factory DigitalGuideDressingRoom.fromJson(Map<String, dynamic> json) =>
      _$DigitalGuideDressingRoomFromJson(json);
}

@freezed
class DigitalGuideTranslationsDressingRoom
    with _$DigitalGuideTranslationsDressingRoom {
  const factory DigitalGuideTranslationsDressingRoom({
    required DigitalGuideTranslationDressingRoom pl,
  }) = _DigitalGuideTranslationsDressingRoom;

  factory DigitalGuideTranslationsDressingRoom.fromJson(
          Map<String, dynamic> json,) =>
      _$DigitalGuideTranslationsDressingRoomFromJson(json);
}

@freezed
class DigitalGuideTranslationDressingRoom
    with _$DigitalGuideTranslationDressingRoom {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DigitalGuideTranslationDressingRoom({
    required String location,
    required String workingDaysAndHours,
    required String comment,
  }) = _DigitalGuideTranslationDressingRoom;
  factory DigitalGuideTranslationDressingRoom.fromJson(
          Map<String, dynamic> json,) =>
      _$DigitalGuideTranslationDressingRoomFromJson(json);
}
