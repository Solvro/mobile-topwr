import "dart:async";

import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../services/translations_service/business/solvro_translator.dart";
import "../../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../../../utils/ref_extensions.dart";
import "../models/booth.dart";

part "booths_repository.g.dart";

class BoothsOfflineException implements Exception {}

abstract class BoothsConfig {
  static const boothsApiUrl = "https://booths-api.topwr.solvro.pl/api/v1/booths/status";
  static const boothsRefreshInterval = Duration(seconds: 15);
}

@riverpod
Future<IList<Booth>> boothsRepository(Ref ref) async {
  final restClient = ref.watch(restClientProvider);
  ref.setRefresh(BoothsConfig.boothsRefreshInterval);
  final booths = await restClient.fetchBooths(BoothsConfig.boothsApiUrl);
  final translator = ref.watch(solvroTranslatorProvider);
  final locale = await ref.watch(preferredLanguageRepositoryProvider.future) ?? SolvroLocale.pl;
  return (await Future.wait(booths.map((booth) => booth.translate(translator, locale)))).toIList();
}

extension DioFetchBoothsX on Dio {
  Future<List<Booth>> fetchBooths(String boothsApiUrl) async {
    try {
      final response = await get<List<dynamic>>(
        boothsApiUrl,
        options: Options(headers: {"accept": "application/json"}),
      );
      return response.data?.whereType<Map<String, dynamic>>().map(Booth.fromJson).toList() ?? [];
    } on DioException catch (_) {
      throw BoothsOfflineException();
    }
  }
}
