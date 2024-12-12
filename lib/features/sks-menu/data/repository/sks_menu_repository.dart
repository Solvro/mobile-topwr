import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../utils/datetime_utils.dart";
import "../../presentation/sks_menu_screen.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_response.dart";

part "sks_menu_repository.g.dart";

@riverpod
class SksMenuRepository extends _$SksMenuRepository {
  static final _mealsUrl = "${Env.sksUrl}/meals/current";
  static const _ttlDays = 1;

  Future<void> clearCache() async {
    return ref.clearCache(_mealsUrl, _ttlDays);
  }

  @override
  Future<ExtendedSksMenuResponse> build() async {
    final sksMenuResponse = await ref.getAndCacheData(
      _mealsUrl,
      _ttlDays,
      SksMenuResponse.fromJson,
      extraValidityCheck: (data) {
        return data.isMenuOnline &&
            DateTime.now().date.isSameDay(data.lastUpdate.date);
      },
      localizedOfflineMessage: SksMenuView.localizedOfflineMessage,
      onRetry: () => ref.invalidateSelf(),
    );

    final trueMeals = sksMenuResponse.meals
        .where((e) => e.category != DishCategory.technicalInfo)
        .toIList();

    final technicalInfos = sksMenuResponse.meals
        .where((e) => e.category == DishCategory.technicalInfo)
        .map((e) => e.name)
        .toIList();

    return ExtendedSksMenuResponse(
      isMenuOnline: sksMenuResponse.isMenuOnline,
      lastUpdate: sksMenuResponse.lastUpdate,
      meals: trueMeals,
      technicalInfos: technicalInfos,
    );
  }
}
