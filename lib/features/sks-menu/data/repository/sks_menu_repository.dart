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
  const mealsEndpoint = "/meals";
  final response = await dio.get(mealsEndpoint);

  final List<SksMenuDish> sksMenuDataList = (response.data as List<dynamic>)
      .map((e) => SksMenuDish.fromJson(e as Map<String, dynamic>))
      .toList()
    ..sort((a, b) => a.category.index.compareTo(b.category.index));

  final Map<DishCategory, List<SksMenuDish>> groupedData = groupBy(
    sksMenuDataList,
    (SksMenuDish data) => data.category,
  );

  return groupedData.toIMap();
}
