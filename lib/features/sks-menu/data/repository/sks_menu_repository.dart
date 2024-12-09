import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/cache/cache.dart";
import "../../../../config/env.dart";
import "../../../../utils/datetime_utils.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_response.dart";

part "sks_menu_repository.g.dart";

@riverpod
Future<ExtendedSksMenuResponse> getSksMenuData(Ref ref) async {
  final mealsUrl = "${Env.sksUrl}/meals/current";
  const ttlDays = 1;

  final sksMenuResponse = await ref.getAndCacheData(
    mealsUrl,
    ttlDays,
    SksMenuResponse.fromJson,
    extraValidityCheck: (data) =>
        data.isMenuOnline && DateTime.now().date == data.lastUpdate.date,
  );

  final trueMeals = sksMenuResponse.meals
      .where((e) => e.category != DishCategory.technicalInfo)
      .toList();

  final technicalInfos = sksMenuResponse.meals
      .where((e) => e.category == DishCategory.technicalInfo)
      .map((e) => e.name)
      .toList();

  return ExtendedSksMenuResponse(
    isMenuOnline: sksMenuResponse.isMenuOnline,
    lastUpdate: sksMenuResponse.lastUpdate,
    meals: trueMeals,
    technicalInfos: [
      ...technicalInfos,
    ],
  );
}
