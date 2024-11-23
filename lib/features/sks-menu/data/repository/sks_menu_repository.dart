import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../shared_api_clients/sks_api_client.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_data.dart";
import "../models/sks_menu_response.dart";

part "sks_menu_repository.g.dart";

@riverpod
Future<IMap<DishCategory, List<SksMenuDish>>> getSksMenuData(Ref ref) async {
  const mealsEndpoint = "/api/v1/meals/current";

  final dio = ref.read(sksClientProvider);
  final response = await dio.get(mealsEndpoint);
  final SksMenuResponse sksMenuResponse =
      SksMenuResponse.fromJson(response.data as Map<String, dynamic>);

  return sksMenuResponse.isMenuOnline
      ? groupBy(sksMenuResponse.meals, (SksMenuDish data) => data.category)
          .toIMap()
      : <DishCategory, List<SksMenuDish>>{}.toIMap();
}
