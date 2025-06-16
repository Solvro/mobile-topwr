import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "tags.freezed.dart";
part "tags.g.dart";
part "tags.translatable.g.dart";

@freezed
@translatable
abstract class TagsData with _$TagsData, _$TagsDataTranslatable {
  const factory TagsData({required IList<Tag> data}) = _TagsData;
  const TagsData._();
  factory TagsData.fromJson(Map<String, dynamic> json) => _$TagsDataFromJson(json);
}

@freezed
abstract class Tag with _$Tag {
  const factory Tag({@translatableField required String tag}) = _Tag;
  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
