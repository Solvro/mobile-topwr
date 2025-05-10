import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../config/ttl_config.dart";

import "../model/holiday.dart";

part "holiday_repo.g.dart";

@riverpod
Future<HolidayList> holidayRepo(Ref ref) async {
  final apiUrl = Env.mainRestApiUrl;
  const holidaysEndpoint = "/holidays/";

  final response = await Future.wait([
    ref.getAndCacheData(
      apiUrl + holidaysEndpoint,
      TtlStrategy.get(TtlKey.holidayRepository).inDays,
      HolidayList.fromJson,
      extraValidityCheck: (_) => true,
      localizedOfflineMessage: "holiday_view.offline_message",
      onRetry: ref.invalidateSelf,
    ),
  ]);
  return response.first;
}
