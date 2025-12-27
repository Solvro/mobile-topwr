import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "controllers_set.dart";

typedef MapDataControllerState<T extends GoogleNavigable> = ({IList<T> data, bool isFilterStrEmpty});

mixin MapDataController<T extends GoogleNavigable> on $AsyncNotifier<MapDataControllerState<T>> {
  var _textFieldFilterText = "";
  late final MapControllers<T> mapControllers;

  FutureOr<MapDataControllerState<T>> build() async {
    final itemSelected = ref.watch(mapControllers.activeMarker);
    if (itemSelected != null) {
      return (
        data: [itemSelected].lock,
        isFilterStrEmpty: _textFieldFilterText.isEmpty,
      ); // shows only selected building
    }

    final itemsData = await ref.watch(mapControllers.sourceRepo.future);
    return (data: itemsData.where(_filterMethod).toIList(), isFilterStrEmpty: _textFieldFilterText.isEmpty);
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
