import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "activity_days_stands_response.dart";

part "activity_days_stand_response.freezed.dart";
part "activity_days_stand_response.g.dart";
part "activity_days_stand_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DasStandResponse with _$DasStandResponse, _$DasStandResponseTranslatable {
  const factory DasStandResponse(@translatableField DasStand data) = _DasStandResponse;

  const DasStandResponse._();

  factory DasStandResponse.fromJson(Map<String, dynamic> json) => _$DasStandResponseFromJson(json);
}
