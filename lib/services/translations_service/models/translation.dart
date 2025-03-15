import "package:freezed_annotation/freezed_annotation.dart";

part "translation.freezed.dart";
part "translation.g.dart";

@freezed
abstract class Translation with _$Translation {
  const factory Translation({
    required String hash,
    required String originalText,
    required String translatedText,
    required String originalLanguageCode,
    required String translatedLanguageCode,
    required bool isApproved,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Translation;

  factory Translation.fromJson(Map<String, dynamic> json) => _$TranslationFromJson(json);
}

@freezed
abstract class TranslationRequest with _$TranslationRequest {
  const factory TranslationRequest({
    required String originalText,
    required String originalLanguageCode,
    required String translatedLanguageCode,
  }) = _TranslationRequest;

  factory TranslationRequest.fromJson(Map<String, dynamic> json) => _$TranslationRequestFromJson(json);
}
