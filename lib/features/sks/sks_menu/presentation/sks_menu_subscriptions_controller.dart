import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../utils/contains_lower_case.dart";
import "../data/models/sks_menu_data.dart";
import "../data/repository/sks_menu_subscription_repository.dart";

part "sks_menu_subscriptions_controller.g.dart";

@Riverpod(dependencies: [])
class SksMenuSubscriptionsController extends _$SksMenuSubscriptionsController {
  @override
  String build() => "";

  void onTextChanged(String newValue) {
    state = newValue;
  }
}

@Riverpod(dependencies: [SksMenuSubscriptionsController])
Future<(IList<SksMenuDishMinimal>, IList<SksMenuDishMinimal>)> sksMenuSubscriptions(Ref ref) async {
  final originalLists = await ref.watch(sksMenuSubscriptionRepositoryProvider.future);
  final query = ref.watch(sksMenuSubscriptionsControllerProvider);
  final list1 = originalLists.$1.where((element) => element.name.containsLowerCase(query)).toIList();
  final list2 = originalLists.$2.where((element) => element.name.containsLowerCase(query)).toIList();
  return (list1, list2);
}
