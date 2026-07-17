import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";

part "activity_days_stands_response.freezed.dart";
part "activity_days_stands_response.g.dart";
part "activity_days_stands_response.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class DasStandsListResponse with _$DasStandsListResponse, _$DasStandsListResponseTranslatable {
  const factory DasStandsListResponse(@translatableField IList<DasStand> data) = _DasStandsListResponse;

  const DasStandsListResponse._();

  factory DasStandsListResponse.fromJson(Map<String, dynamic> json) => _$DasStandsListResponseFromJson(json);
}

@freezed
abstract class DasStand with _$DasStand {
  const factory DasStand({
    required int id,
    required int dasId,
    required String number,
    @translatableField required String name,
    @translatableField String? description,
    int? floorId,
    @translatableField DasFloor? floor,
    @translatableField DasOrganization? dasOrganization,
    ImageData? logo,
  }) = _DasStand;

  factory DasStand.fromJson(Map<String, dynamic> json) => _$DasStandFromJson(json);
}

extension DasStandFallbacks on DasStand {
  String get effectiveName => name.trim().isNotEmpty ? name : (dasOrganization?.name ?? "");

  String? get effectiveDescription {
    final standDescription = description?.trim();
    if (standDescription != null && standDescription.isNotEmpty) return description;
    return dasOrganization?.description;
  }
}

@freezed
abstract class DasFloor with _$DasFloor {
  const factory DasFloor({required int id, @translatableField required String name}) = _DasFloor;

  factory DasFloor.fromJson(Map<String, dynamic> json) => _$DasFloorFromJson(json);
}

@freezed
abstract class DasOrganization with _$DasOrganization {
  const factory DasOrganization({
    required int id,
    @translatableField required String name,
    @translatableField String? description,
    DasStudentOrganization? studentOrganization,
  }) = _DasOrganization;

  factory DasOrganization.fromJson(Map<String, dynamic> json) => _$DasOrganizationFromJson(json);
}

@freezed
abstract class DasStudentOrganization with _$DasStudentOrganization {
  const factory DasStudentOrganization({required int id, required String name}) = _DasStudentOrganization;

  factory DasStudentOrganization.fromJson(Map<String, dynamic> json) => _$DasStudentOrganizationFromJson(json);
}
