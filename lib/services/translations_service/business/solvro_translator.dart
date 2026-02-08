import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";
import "package:solvro_translator_with_drift_cache_flutter/solvro_translator_with_drift_cache_flutter.dart";

import "../../../config/env.dart";

part "solvro_translator.g.dart";

@Riverpod(keepAlive: true)
SolvroTranslatorWithDriftCache solvroTranslator(Ref ref) {
  return SolvroTranslatorWithDriftCache((
    databaseName: "translations_database_new",
    dio: Dio(BaseOptions(baseUrl: Env.translateApiUrl, headers: {"x-api-token": Env.translateApiToken})),
    sourceLocale: SolvroLocale.pl,
    batchConfig: BatchTranslationConfig.defaultConfig,
  ));
}
