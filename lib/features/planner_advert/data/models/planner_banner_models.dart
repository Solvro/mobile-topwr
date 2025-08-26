import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "planner_banner_models.freezed.dart";
part "planner_banner_models.g.dart";
part "planner_banner_models.translatable.g.dart";

@freezed
@Translatable(makeFieldsTranslatableByDefault: false)
abstract class PlannerBannerResponse with _$PlannerBannerResponse, _$PlannerBannerResponseTranslatable {
  const factory PlannerBannerResponse({@translatableField required IList<PlannerBanner> data}) = _PlannerBannerResponse;

  const PlannerBannerResponse._();

  factory PlannerBannerResponse.fromJson(Map<String, dynamic> json) => _$PlannerBannerResponseFromJson(json);
}

@freezed
abstract class PlannerBanner with _$PlannerBanner {
  const factory PlannerBanner({
    required int id,
    @translatableField String? title,
    @translatableField @Default("") String description,
    String? url,
    @Default(false) bool draft,
    String? textColor,
    String? backgroundColor,
    String? titleColor,
    DateTime? visibleFrom,
    DateTime? visibleUntil,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool shouldRender,
  }) = _PlannerBanner;

  factory PlannerBanner.fromJson(Map<String, dynamic> json) => _$PlannerBannerFromJson(json);
}
