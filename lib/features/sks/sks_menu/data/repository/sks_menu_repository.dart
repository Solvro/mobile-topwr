import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/cache/cache.dart";
import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../../config/ttl_config.dart";
import "../../../../../features/remote_config/data/repository/remote_config_repository.dart";
import "../../../../../utils/datetime_utils.dart";
import "../../../../../utils/ilist_nonempty.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_response.dart";
import "../models/sks_opening_hours.dart";

part "sks_menu_repository.g.dart";

@riverpod
class SksMenuRepository extends _$SksMenuRepository {
  static const _ttlDaysMeals = TtlDays.defaultSksMenu;
  static const _ttlDaysOpeningHours = TtlDays.defaultSks;

  Future<void> clearCache() async {
    final remoteConfig = await ref.read(remoteConfigRepositoryProvider.future);
    final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
    final sksApiBaseUrl = "$sksUrl/api/v1";
    await ref.clearCache("$sksApiBaseUrl/meals/current", _ttlDaysMeals);
    await ref.clearCache("$sksApiBaseUrl/info", _ttlDaysOpeningHours);
    ref.invalidateSelf();
  }

  @override
  Future<ExtendedSksMenuResponse> build() async {
    final remoteConfig = await ref.watch(remoteConfigRepositoryProvider.future);
    final sksUrl = remoteConfig.sksMicroserviceUrl ?? Env.sksUrl;
    final sksApiBaseUrl = "$sksUrl/api/v1";
    final mealsUrl = "$sksApiBaseUrl/meals/current";
    final openingHoursUrl = "$sksApiBaseUrl/info";

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

    final openingHoursResponse = await ref
        .getAndCacheData(
          openingHoursUrl,
          SksOpeningHours.fromJson,
          ttlDays: _ttlDaysOpeningHours,
          extraValidityCheck: (data) {
            final obj = data.castAsObject;
            return obj.openingHours.canteen.openingTime.isNotEmpty &&
                obj.openingHours.canteen.closingTime.isNotEmpty &&
                obj.openingHours.cafe.openingTime.isNotEmpty &&
                obj.openingHours.cafe.closingTime.isNotEmpty;
          },
          onRetry: ref.invalidateSelf,
        )
        .castAsObject;

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
      openingHours: openingHoursResponse.openingHours,
    );
  }
}
