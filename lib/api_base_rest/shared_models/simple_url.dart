import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "simple_url.freezed.dart";
part "simple_url.g.dart";

@freezed
abstract class SimpleUrl with _$SimpleUrl {
  const factory SimpleUrl({@nonTranslatableField required String url}) = _SimpleUrl;

  factory SimpleUrl.fromJson(Map<String, dynamic> json) => _$SimpleUrlFromJson(json);
}
