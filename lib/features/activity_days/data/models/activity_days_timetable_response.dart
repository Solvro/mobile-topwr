import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "activity_days_response.dart";

part "activity_days_timetable_response.freezed.dart";
part "activity_days_timetable_response.g.dart";
part "activity_days_timetable_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class ActivityDaysTimetableResponse
    with _$ActivityDaysTimetableResponse, _$ActivityDaysTimetableResponseTranslatable {
  const factory ActivityDaysTimetableResponse(@translatableField ActivityDaysTimetable data) =
      _ActivityDaysTimetableResponse;

  const ActivityDaysTimetableResponse._();

  factory ActivityDaysTimetableResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityDaysTimetableResponseFromJson(json);
}
