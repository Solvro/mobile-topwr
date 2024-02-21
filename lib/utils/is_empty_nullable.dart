extension IsEmptyNullableExt<T> on Iterable<T>? {
  bool get isEmptyNullable {
    return this?.isEmpty == true;
  }
}
