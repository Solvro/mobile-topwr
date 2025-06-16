import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

part "image_data.freezed.dart";
part "image_data.g.dart";

@freezed
abstract class ImageData with _$ImageData {
  const factory ImageData({@nonTranslatableField required String url}) = _ImageData;

  factory ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataFromJson(json);
}
