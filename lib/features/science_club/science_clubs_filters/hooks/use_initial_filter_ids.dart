import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_hooks/flutter_hooks.dart";

import "../../../../utils/unwaited_microtask.dart";
import "../filters_controller.dart";

// use this hook to load initial set of filters when the widget is first built
void useInitialFilterIds<T>(
  IList<String>? ids,
  Future<IList<T>> Function() itemsCallback,
  FilterController<T> filterController,
  bool Function(IList<String> ids, T item) test,
) {
  if (ids == null) return;
  useEffect(() {
    var cancelled = false;
    unwaitedMicrotask(() async {
      final items = await itemsCallback();
      if (cancelled) return;
      filterController.clearFilter();
      if (cancelled) return;
      for (final item in items.where((item) => test(ids, item))) {
        if (cancelled) return;
        filterController.toggleFilter(item);
      }
    });
    return () {
      cancelled = true;
    };
  }, [ids]);
}
