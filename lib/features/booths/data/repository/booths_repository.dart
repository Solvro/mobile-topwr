import "dart:async";

import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../../../../services/translations_service/business/solvro_translator.dart";
import "../../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../../../utils/ref_extensions.dart";
import "../../../remote_config/data/repository/remote_config_repository.dart";
import "../models/booth.dart";

part "booths_repository.g.dart";

class BoothsOfflineException implements Exception {}

abstract class BoothsConfig {
  static const boothsRefreshInterval = Duration(seconds: 15);
}

@riverpod
Future<IList<Booth>> boothsRepository(Ref ref) async {
  final restClient = ref.watch(restClientProvider);
  final remoteConfig = await ref.watch(remoteConfigRepositoryProvider.future);
  final remoteBoothsApiBaseUrl = remoteConfig.boothsApiBaseUrl?.trim();
  final boothsApiBaseUrl = remoteBoothsApiBaseUrl == null || remoteBoothsApiBaseUrl.isEmpty
      ? Env.boothsApiBaseUrl
      : remoteBoothsApiBaseUrl;
  if (!remoteConfig.boothsEnabled || boothsApiBaseUrl.trim().isEmpty) {
    throw BoothsOfflineException();
  }

  ref.setRefresh(BoothsConfig.boothsRefreshInterval);
  final booths = await restClient.fetchBooths(boothsApiBaseUrl);
  final translator = ref.watch(solvroTranslatorProvider);
  final locale = await ref.watch(preferredLanguageRepositoryProvider.future) ?? SolvroLocale.pl;
  return (await Future.wait(booths.map((booth) => booth.translate(translator, locale)))).toIList();
}

extension DioFetchBoothsX on Dio {
  Future<List<Booth>> fetchBooths(String boothsApiUrl) async {
    try {
      final normalizedUrl = boothsApiUrl.endsWith("/status")
          ? boothsApiUrl
          : "${boothsApiUrl.replaceFirst(RegExp(r'/*$'), '')}/booths/status";
      final response = await get<List<dynamic>>(
        normalizedUrl,
        options: Options(headers: {"accept": "application/json"}),
      );
      return response.data?.whereType<Map<String, dynamic>>().map(Booth.fromJson).toList() ?? [];
    } on DioException catch (_) {
      throw BoothsOfflineException();
    }
  }
}
