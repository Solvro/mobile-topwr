import "package:drift/drift.dart" hide JsonKey;
import "package:freezed_annotation/freezed_annotation.dart";

import "../data_source/local/database/translations_database.dart";
import "supported_languages.dart";

part "translation.freezed.dart";
part "translation.g.dart";

@freezed
abstract class TranslationResponse with _$TranslationResponse {
  factory TranslationResponse({
    required String hash,
    required String originalText,
    required String translatedText,
    required String originalLanguageCode,
    required String translatedLanguageCode,
    required bool isApproved,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _TranslationResponse;

  TranslationResponse._();

  Translation getTranslation() => Translation(
    originalTextHash: originalText.hashCode, 
    translatedText: translatedText, 
    originalLanguageCode: SupportedLocales.fromString(originalLanguageCode), 
    translatedLanguageCode: SupportedLocales.fromString(translatedLanguageCode), 
    isApproved: isApproved, 
    createdAt: DateTime.now(), 
  );

  factory TranslationResponse.fromJson(Map<String, dynamic> json) => _$TranslationResponseFromJson(json);
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

class Translations extends Table {
  IntColumn get originalTextHash => integer()(); 
  TextColumn get translatedText => text()();
  IntColumn get originalLanguageCode => intEnum<SupportedLocales>().withDefault(Constant(SupportedLocales.pl.index))();
  IntColumn get translatedLanguageCode => intEnum<SupportedLocales>()();
  BoolColumn get isApproved => boolean()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {originalTextHash, translatedLanguageCode}; 
}
