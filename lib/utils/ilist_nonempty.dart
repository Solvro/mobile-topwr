import "package:fast_immutable_collections/fast_immutable_collections.dart";

extension IListNonemptyX<T> on Iterable<T>? {
  IList<T> toIList() => this?.toIList() ?? const IList.empty();
}
