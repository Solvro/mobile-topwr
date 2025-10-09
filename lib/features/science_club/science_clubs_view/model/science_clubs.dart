import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/shared_models/simple_url.dart";
import "../../../branches/data/model/branch.dart";
import "../../../departments/departments_view/data/models/department.dart";
import "../../science_clubs_filters/model/sci_club_type.dart";
import "../../science_clubs_filters/model/tags.dart";

part "science_clubs.freezed.dart";
part "science_clubs.g.dart";
part "science_clubs.translatable.g.dart";

@JsonEnum(fieldRename: FieldRename.snake)
enum ScienceClubStatus { active, archived, unknown }

@JsonEnum(fieldRename: FieldRename.snake)
enum ScienceClubSource {
  @JsonValue("manual")
  manualEntry,
  @JsonValue("pwr_active")
  pwrActiveWebsite,
  studentDepartment,
}

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class ScienceClubsResponse with _$ScienceClubsResponse, _$ScienceClubsResponseTranslatable {
  const factory ScienceClubsResponse({@translatableField required IList<ScienceClub> data}) = _ScienceClubsResponse;

  const ScienceClubsResponse._();

  factory ScienceClubsResponse.fromJson(Map<String, dynamic> json) => _$ScienceClubsResponseFromJson(json);
}

@freezed
abstract class ScienceClub with _$ScienceClub {
  const factory ScienceClub({
    required int id,
    @translatableField required String name,
    required ScienceClubStatus organizationStatus,
    required ScienceClubSource source,
    required ScienceClubType organizationType,
    required bool coverPreview,
    required bool isStrategic,
    required Branch branch,
    @translatableField IList<Tag>? tags,
    SimpleUrl? logo,
    SimpleUrl? cover,
    @translatableField String? shortDescription,
    @translatableField Department? department,
  }) = _ScienceClub;

  factory ScienceClub.fromJson(Map<String, dynamic> json) => _$ScienceClubFromJson(json);
}
