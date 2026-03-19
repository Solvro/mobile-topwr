import "package:fast_immutable_collections/fast_immutable_collections.dart";
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
  final originalMap = ref.watch(sksFavouriteDishesRepositoryProvider);
  final query = ref.watch(sksFavouriteDishesControllerProvider);
  return originalMap.asData?.value.values
          .where((entry) => entry.isSubscribed && entry.dish.name.containsLowerCase(query))
          .map((entry) => entry.dish)
          .toIList() ??
      const IList.empty();
}

@Riverpod(dependencies: [SksFavouriteDishesController])
IList<SksMenuDishMinimal> unsubscribedDishes(Ref ref) {
  final originalMap = ref.watch(sksFavouriteDishesRepositoryProvider);
  final query = ref.watch(sksFavouriteDishesControllerProvider);
  return originalMap.asData?.value.values
          .where((entry) => !entry.isSubscribed && entry.dish.name.containsLowerCase(query))
          .map((entry) => entry.dish)
          .toIList() ??
      const IList.empty();
}
