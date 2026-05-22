import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:solvro_translator_core/solvro_translator_core.dart";

import "../../../../../api_base_rest/cache/cache.dart";
import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../../../../../services/translations_service/data/preferred_lang_repository.dart";
import "../../../../../utils/datetime_utils.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_response.dart";
import "../models/sks_opening_hours.dart";

part "sks_menu_repository.g.dart";

final class _SksMenuRepositoryDisposed implements Exception {
  const _SksMenuRepositoryDisposed();
}

@riverpod
class SksMenuRepository extends _$SksMenuRepository {
  static const _ttlDaysMeals = TtlDays.defaultSksMenu;
  static const _ttlDaysOpeningHours = TtlDays.defaultSks;

  Future<void> clearCache() async {
    final remoteConfig = await ref.read(remoteConfigRepositoryProvider.future);
    if (!ref.mounted) return;

    final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
    final sksApiBaseUrl = "$sksUrl/api/v1";
    final mainApiBaseUrl = Env.mainRestApiUrl;
    await ref.clearCache("$sksApiBaseUrl/meals/current", _ttlDaysMeals);
    if (!ref.mounted) return;

    await ref.clearCache("$mainApiBaseUrl/sks_opening_hours", _ttlDaysOpeningHours);
  }

  @override
  Future<ExtendedSksMenuResponse> build() async {
    final remoteConfigFuture = ref.watch(remoteConfigRepositoryProvider.future);
    final localeFuture = ref.watch(preferredLanguageRepositoryProvider.future);

    final remoteConfig = await remoteConfigFuture;
    if (!ref.mounted) throw const _SksMenuRepositoryDisposed();

    final locale = await localeFuture ?? SolvroLocale.pl;
    if (!ref.mounted) throw const _SksMenuRepositoryDisposed();

    final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
    final sksApiBaseUrl = "$sksUrl/api/v1";
    final mainApiBaseUrl = Env.mainRestApiUrl;
    final mealsUrl = "$sksApiBaseUrl/meals/current";
    final openingHoursUrl = "$mainApiBaseUrl/sks_opening_hours";

    final sksMenuResponse = await ref
        .getAndCacheDataWithTranslation(
          mealsUrl,
          SksMenuResponse.fromJson,
          ttlDays: _ttlDaysMeals,
          extraValidityCheck: (data) {
            final now = DateTime.now();
            // If the backend's last update time is before 11:00, we don't want to rely on it.
            final obj = data.castAsObject;
            return obj.isMenuOnline && now.date.isSameDay(obj.lastUpdate.date) && obj.lastUpdate.hour >= 11;
          },
          onRetry: ref.invalidateSelf,
        )
        .castAsObject;
    if (!ref.mounted) throw const _SksMenuRepositoryDisposed();

    final openingHoursResponse = await ref
        .getAndCacheData(
          openingHoursUrl,
          SksOpeningHoursResponse.fromJson,
          ttlDays: _ttlDaysOpeningHours,
          extraValidityCheck: (data) => data.castAsObject.data.isNotEmpty,
          onRetry: ref.invalidateSelf,
        )
        .castAsObject;

    final preferredLang = locale == SolvroLocale.pl ? "pl" : "en";
    final openingHours =
        openingHoursResponse.data.firstWhereOrNull((e) => e.language == preferredLang) ??
        openingHoursResponse.data.firstOrNull;

    final trueMeals = sksMenuResponse.meals.where((e) => e.category != DishCategory.technicalInfo).toIList();

    final technicalInfos = sksMenuResponse.meals
        .where((e) => e.category == DishCategory.technicalInfo)
        .map((e) => e.name)
        .toIList();

    return ExtendedSksMenuResponse(
      isMenuOnline: sksMenuResponse.isMenuOnline,
      lastUpdate: sksMenuResponse.lastUpdate,
      meals: trueMeals,
      technicalInfos: technicalInfos,
      openingHours: openingHours,
    );
  }
}
