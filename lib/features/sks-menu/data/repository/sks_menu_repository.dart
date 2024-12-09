import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_response.dart";

part "sks_menu_repository.g.dart";

@riverpod
Future<ExtendedSksMenuResponse> getSksMenuData(Ref ref) async {
  final mealsUrl = "${Env.sksUrl}/meals/current";

  final dio = ref.read(restClientProvider);
  final response = await dio.get(mealsUrl);
  final SksMenuResponse sksMenuResponse =
      SksMenuResponse.fromJson(response.data as Map<String, dynamic>);

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
