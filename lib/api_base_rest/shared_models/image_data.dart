import "package:freezed_annotation/freezed_annotation.dart";

part "image_data.freezed.dart";
part "image_data.g.dart";

@freezed
abstract class ImageData with _$ImageData {
  const factory ImageData({required String url}) = _ImageData;

  factory ImageData.fromJson(Map<String, dynamic> json) => _$ImageDataFromJson(json);
}
