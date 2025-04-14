import "package:drift/drift.dart" hide JsonKey;
import "package:freezed_annotation/freezed_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart" show SolvroLocale, TranslationResults;

import "../data_source/local/database/translations_database.dart";

part "translation.freezed.dart";
part "translation.g.dart";

@freezed
abstract class TranslationResponse with _$TranslationResponse implements TranslationResults {
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
    originalLanguageCode: SolvroLocale.values.byName(originalLanguageCode),
    translatedLanguageCode: SolvroLocale.values.byName(translatedLanguageCode),
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
  IntColumn get originalLanguageCode => intEnum<SolvroLocale>().withDefault(Constant(SolvroLocale.pl.index))();
  IntColumn get translatedLanguageCode => intEnum<SolvroLocale>()();
  BoolColumn get isApproved => boolean()();
  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();

  @override
  Set<Column> get primaryKey => {originalTextHash, translatedLanguageCode};
}

class TranslationWithInterface extends Translation implements TranslationResults {
  TranslationWithInterface.fromTranslation(Translation translation)
    : super(
        originalTextHash: translation.originalTextHash,
        translatedText: translation.translatedText,
        originalLanguageCode: translation.originalLanguageCode,
        translatedLanguageCode: translation.translatedLanguageCode,
        isApproved: translation.isApproved,
        createdAt: translation.createdAt,
      );
}
