import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "calendar_data.freezed.dart";
part "calendar_data.g.dart";
part "calendar_data.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class CalendarDataResponse with _$CalendarDataResponse, _$CalendarDataResponseTranslatable {
  const factory CalendarDataResponse(@translatableField IList<CalendarData> data) = _CalendarDataResponse;

  const CalendarDataResponse._();

  factory CalendarDataResponse.fromJson(Map<String, dynamic> json) => _$CalendarDataResponseFromJson(json);
}

@freezed
abstract class CalendarData with _$CalendarData {
  const factory CalendarData({
    required int id,
    @translatableField required String name,
    required String startTime,
    required String endTime,
    @translatableField required String? location,
    @translatableField required String? description,
  }) = _CalendarData;

  factory CalendarData.fromJson(Map<String, dynamic> json) => _$CalendarDataFromJson(json);
}
