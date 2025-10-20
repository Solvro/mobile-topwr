import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../utils/contains_lower_case.dart";
import "../../sks_menu/data/models/sks_menu_data.dart";
import "../data/repository/sks_favourite_dishes_repository.dart";

part "sks_favourite_dishes_controller.g.dart";

@Riverpod(dependencies: [])
class SksFavouriteDishesController extends _$SksFavouriteDishesController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@Riverpod(dependencies: [SksFavouriteDishesController])
IList<SksMenuDishMinimal> subscribedDishes(Ref ref) {
  final originalLists = ref.watch(sksFavouriteDishesRepositoryProvider);
  final query = ref.watch(sksFavouriteDishesControllerProvider);
  return originalLists.asData?.value.$1.where((element) => element.name.containsLowerCase(query)).toIList() ??
      const IList.empty();
}

@Riverpod(dependencies: [SksFavouriteDishesController])
IList<SksMenuDishMinimal> unsubscribedDishes(Ref ref) {
  final originalLists = ref.watch(sksFavouriteDishesRepositoryProvider);
  final query = ref.watch(sksFavouriteDishesControllerProvider);
  print(query);
  return originalLists.asData?.value.$2.where((element) => element.name.containsLowerCase(query)).toIList() ??
      const IList.empty();
}
