import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../filters_controller.dart";

void useInitialFilterIds<T>(
  IList<String>? ids,
  Future<IList<T>> Function() itemsCallback,
  FilterController<T> filterController,
  bool Function(IList<String> ids, T item) test,
) {
  if (ids == null) return;
  useEffect(
    () {
      Future.microtask(() async {
        final items = await itemsCallback();
        filterController.clearFilter();
        items.where((item) => test(ids, item)).forEach(
              filterController.toggleFilter,
            );
      });
      return null;
    },
    [ids],
  );
}
