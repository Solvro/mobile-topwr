// ignore_for_file: invalid_annotation_target

import "package:freezed_annotation/freezed_annotation.dart";

part "image_response.freezed.dart";
part "image_response.g.dart";

@freezed
class ImageResponse with _$ImageResponse {
  const factory ImageResponse({
    @JsonKey(name: "image_960w") required String imageUrl,
  }) = _ImageResponse;

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);
}
