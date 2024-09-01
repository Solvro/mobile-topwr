import "package:fast_immutable_collections/fast_immutable_collections.dart";

extension LastOrNullX<T> on IList<T> {
  T? get lastOrNull => isNotEmpty ? last : null;

  T? get preLastOrNull => length > 1 ? this[length - 2] : null;

  T? get prePreLastOrNull => length > 2 ? this[length - 3] : null;
}
