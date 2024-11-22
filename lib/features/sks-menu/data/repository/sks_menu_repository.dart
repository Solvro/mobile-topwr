import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../shared_api_clients/sks_api_client.dart";
import "../models/dish_category_enum.dart";
import "../models/sks_menu_data.dart";

part "sks_menu_repository.g.dart";

@riverpod
Future<IMap<DishCategory, List<SksMenuDish>>> getSksMenuData(Ref ref) async {

  final dio = ref.read(sksClientProvider);
  const mealsEndpoint = "/api/v1/meals/current";
  final response = await dio.get(mealsEndpoint);

  if(!response.data['isMenuOnline']) return <DishCategory, List<SksMenuDish>>{}.toIMap();

  final List<SksMenuDish> sksMenuDishesList = (response.data["meals"] as List<dynamic>)
      .map((dish) => SksMenuDish.fromJson(dish as Map<String, dynamic>))
      .toList()
      ..sort((a, b) => a.category.index.compareTo(b.category.index));

  final Map<DishCategory, List<SksMenuDish>> groupedData = groupBy(
    sksMenuDishesList,
    (SksMenuDish data) => data.category,
  );

  return groupedData.toIMap();
}
