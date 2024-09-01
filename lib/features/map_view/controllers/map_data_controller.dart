import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "controllers_set.dart";

mixin MapDataController<T extends GoogleNavigable>
    on AutoDisposeAsyncNotifier<IList<T>> {
  String _textFieldFilterText = "";
  late final MapControllers<T> mapControllers;

  @override
  FutureOr<IList<T>> build() async {
    final itemSelected = ref.watch(mapControllers.activeMarker);
    if (itemSelected != null) {
      return [itemSelected].lock; // shows only selected building
    }

    final itemsData = await ref.watch(mapControllers.sourceRepo.future);
    return itemsData.where(_filterMethod).toIList();
  }

  bool filterMethod(T item, String filterStr);

  bool _filterMethod(T item) {
    final filter = _textFieldFilterText.toLowerCase();
    return filterMethod(item, filter);
  }

  void onSearchQueryChanged(String newText) {
    _textFieldFilterText = newText;
    ref.read(mapControllers.activeMarker.notifier).unselect();
    ref.invalidateSelf();
  }
}
