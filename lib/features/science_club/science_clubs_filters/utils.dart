import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "filters_controller.dart";

typedef FilterControllerProvider<T> = $NotifierProvider<FilterController<T>, ISet<T>>;

extension WatchSelectContainsX on WidgetRef {
  bool watchContains<T>(FilterControllerProvider<T> selectedProvider, T valueToCheck) =>
      watch(selectedProvider.select((value) => value.contains(valueToCheck)));
}
