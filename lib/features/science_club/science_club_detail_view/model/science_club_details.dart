import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";
import "../../../../api_base_rest/shared_models/social_links_data.dart";
import "../../../departments/departments_view/data/models/department.dart";
import "../../science_clubs_filters/model/tags.dart";
import "../../science_clubs_view/model/science_clubs.dart";

part "science_club_details.freezed.dart";
part "science_club_details.g.dart";
part "science_club_details.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class ClubDetailsResponse with _$ClubDetailsResponse, _$ClubDetailsResponseTranslatable {
  const factory ClubDetailsResponse({@translatableField required ScienceClubDetails data}) = _ClubDetailsResponse;
  const ClubDetailsResponse._();
  factory ClubDetailsResponse.fromJson(Map<String, dynamic> json) => _$ClubDetailsResponseFromJson(json);
}

@freezed
abstract class ScienceClubDetails with _$ScienceClubDetails {
  const factory ScienceClubDetails({
    @translatableField required String name,
    required ScienceClubSource source,
    required bool isStrategic,
    @translatableField String? description,
    ImageData? cover,
    @translatableField IList<SocialLinksData>? links,
    ImageData? logo,
    @translatableField Department? department,
    @translatableField IList<Tag>? tags,
  }) = _ScienceClubDetails;

  factory ScienceClubDetails.fromJson(Map<String, dynamic> json) => _$ScienceClubDetailsFromJson(json);
}
