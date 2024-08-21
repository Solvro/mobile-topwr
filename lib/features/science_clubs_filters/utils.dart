import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "filters_controller.dart";

typedef FilterControllerProvider<T>
    = AutoDisposeNotifierProvider<FilterController<T>, ISet<T>>;

extension WatchSelectNotEmptyX<T> on AutoDisposeProvider<IList<T>> {
  ProviderListenable<bool> get notEmpty => select(
        (value) => value.isNotEmpty,
      );
}

extension WatchAsyncSelectNotEmptyX<T> on AutoDisposeFutureProvider<IList<T>> {
  ProviderListenable<bool?> get notEmpty => select(
        (value) => value.value?.isNotEmpty,
      );
}

extension WatchNotifSelectNotEmptyX<T>
    on AutoDisposeNotifierProvider<AutoDisposeNotifier<ISet<T>>, ISet<T>> {
  ProviderListenable<bool> get notEmpty => select(
        (value) => value.isNotEmpty,
      );
}

extension WatchStringSelectNotEmptyX<T>
    on AutoDisposeNotifierProvider<AutoDisposeNotifier<String>, String> {
  ProviderListenable<bool> get notEmpty => select(
        (value) => value.isNotEmpty,
      );
}

extension WatchSelectContainsX on WidgetRef {
  bool watchContains<T>(
    FilterControllerProvider<T> selectedProvider,
    T valueToCheck,
  ) =>
      watch(
        selectedProvider.select(
          (value) => value.contains(valueToCheck),
        ),
      );
}
