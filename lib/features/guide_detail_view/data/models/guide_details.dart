import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";

part "guide_details.freezed.dart";
part "guide_details.g.dart";
part "guide_details.translatable.g.dart";

@freezed
@translatable
abstract class GuideDetailsResponse with _$GuideDetailsResponse, _$GuideDetailsResponseTranslatable {
  const factory GuideDetailsResponse({required GuideDetails data}) = _GuideDetailsResponse;
  const GuideDetailsResponse._();
  factory GuideDetailsResponse.fromJson(Map<String, dynamic> json) => _$GuideDetailsResponseFromJson(json);
}

@freezed
abstract class GuideDetails with _$GuideDetails {
  const factory GuideDetails({
    required String title,
    required String description,
    required String shortDesc,
    required ImageData image,
    required DateTime createdAt,
    required DateTime updatedAt,
    required IList<GuideAuthor> guideAuthors,
    required IList<GuideQuestion> guideQuestions,
  }) = _GuideDetails;

  factory GuideDetails.fromJson(Map<String, dynamic> json) => _$GuideDetailsFromJson(json);
}

@freezed
abstract class GuideQuestion with _$GuideQuestion {
  const factory GuideQuestion({
    required String title,
    required String answer,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _GuideQuestion;

  factory GuideQuestion.fromJson(Map<String, dynamic> json) => _$GuideQuestionFromJson(json);
}

@freezed
abstract class GuideAuthor with _$GuideAuthor {
  const factory GuideAuthor({required String name, @JsonKey(name: "meta") required GuideAuthorRole role}) =
      _GuideAuthor;

  factory GuideAuthor.fromJson(Map<String, dynamic> json) => _$GuideAuthorFromJson(json);
}

@freezed
abstract class GuideAuthorRole with _$GuideAuthorRole {
  const factory GuideAuthorRole({@JsonKey(name: "pivot_role") required GuideAuthorRoleType role}) = _GuideAuthorRole;

  factory GuideAuthorRole.fromJson(Map<String, dynamic> json) => _$GuideAuthorRoleFromJson(json);
}

enum GuideAuthorRoleType {
  @JsonValue("AUTHOR")
  author,
  @JsonValue("REDACTOR")
  redactor,
}
