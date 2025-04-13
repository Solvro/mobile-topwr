import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../../api_base_rest/cache/cache.dart";
import "../../../../../api_base_rest/client/json.dart";
import "../../../../../api_base_rest/translations/translate.dart";
import "../../../../../config/env.dart";
import "../../../../../utils/datetime_utils.dart";
import "../../presentation/sks_menu_screen.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_response.dart";
import "../models/sks_opening_hours.dart";

part "sks_menu_repository.g.dart";

@riverpod
class SksMenuRepository extends _$SksMenuRepository {
  static final _mealsUrl = "${Env.sksUrl}/meals/current";
  static final _openingHoursUrl = "${Env.sksUrl}/info";
  static const _ttlDays = 1;

  Future<void> clearCache() async {
    await ref.clearCache(_mealsUrl, _ttlDays);
    await ref.clearCache(_openingHoursUrl, _ttlDays);
  }

  @override
  Future<ExtendedSksMenuResponse> build() async {
    final sksMenuResponse =
        await ref
            .getAndCacheDataWithTranslation(
              _mealsUrl,
              _ttlDays,
              SksMenuResponse.fromJson,
              extraValidityCheck: (data) {
                return data.castAsObject.isMenuOnline &&
                    DateTime.now().date.isSameDay(data.castAsObject.lastUpdate.date);
              },
              localizedOfflineMessage: SksMenuView.localizedOfflineMessage,
              onRetry: ref.invalidateSelf,
            )
            .castAsObject;

    final openingHoursResponse =
        await ref
            .getAndCacheData(
              _openingHoursUrl,
              _ttlDays,
              SksOpeningHours.fromJson,
              extraValidityCheck: (data) {
                final obj = data.castAsObject;
                return obj.openingHours.canteen.openingTime.isNotEmpty &&
                    obj.openingHours.canteen.closingTime.isNotEmpty &&
                    obj.openingHours.cafe.openingTime.isNotEmpty &&
                    obj.openingHours.cafe.closingTime.isNotEmpty;
              },
              localizedOfflineMessage: SksMenuView.localizedOfflineMessage,
              onRetry: ref.invalidateSelf,
            )
            .castAsObject;

    final trueMeals = sksMenuResponse.meals.where((e) => e.category != DishCategory.technicalInfo).toIList();

    final technicalInfos =
        sksMenuResponse.meals.where((e) => e.category == DishCategory.technicalInfo).map((e) => e.name).toIList();

    return ExtendedSksMenuResponse(
      isMenuOnline: sksMenuResponse.isMenuOnline,
      lastUpdate: sksMenuResponse.lastUpdate,
      meals: trueMeals,
      technicalInfos: technicalInfos,
      openingHours: openingHoursResponse.openingHours,
    );
  }
}
