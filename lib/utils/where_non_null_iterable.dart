Iterable<T> _whereNonNullIterable<T>(Iterable<T?> source) sync* {
  for (final element in source) {
    if (element != null) {
      yield element;
    }
  }
}

extension WhereNonNullExt<T> on Iterable<T?> {
  Iterable<T> get whereNonNull {
    return _whereNonNullIterable(this);
  }
}

extension WhereNonNullExtNullable<T> on Iterable<T?>? {
  Iterable<T> get whereNonNull {
    if (this == null) return [];
    return this!.whereNonNull;
  }
}
