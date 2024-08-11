import "package:fast_immutable_collections/fast_immutable_collections.dart";

extension ToggleISetX<T> on ISet<T> {
  ISet<T> toggle(T elem) {
    if (contains(elem)) {
      return remove(elem);
    } else {
      return add(elem);
    }
  }
}
