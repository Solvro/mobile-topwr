import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "changelog.freezed.dart";
part "changelog.g.dart";
part "changelog.translatable.g.dart";

@freezed
@translatable
abstract class ChangelogDataResponse with _$ChangelogDataResponse, _$ChangelogDataResponseTranslatable {
  const factory ChangelogDataResponse({required IList<Changelog> data}) = _ChangelogDataResponse;
  const ChangelogDataResponse._();
  factory ChangelogDataResponse.fromJson(Map<String, dynamic> json) => _$ChangelogDataResponseFromJson(json);
}

@freezed
abstract class Changelog with _$Changelog {
  const factory Changelog({required String name, required IList<ChangelogChange> changes}) = _Changelog;

  factory Changelog.fromJson(Map<String, dynamic> json) => _$ChangelogFromJson(json);
}

@freezed
abstract class ChangelogChange with _$ChangelogChange {
  const factory ChangelogChange({@JsonKey(name: "type") required TypeOfChange changeType, required String name}) =
      _ChangelogChange;

  factory ChangelogChange.fromJson(Map<String, dynamic> json) => _$ChangelogChangeFromJson(json);
}

enum TypeOfChange {
  @JsonValue("FIX")
  fix,
  @JsonValue("FEATURE")
  feature,
}
