import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../../api_base_rest/shared_models/image_data.dart";

part "guide_details.freezed.dart";
part "guide_details.g.dart";

@freezed
abstract class GuideDetailsResponse with _$GuideDetailsResponse {
  const factory GuideDetailsResponse({required GuideDetails data}) = _GuideDetailsResponse;
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
