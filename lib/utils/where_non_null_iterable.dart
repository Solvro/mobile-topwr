Iterable<T> _whereNonNullIterable<T>(Iterable<T?> source) sync* {
  for (final element in source) {
    if (element != null) {
      yield element;
    }
  }
}

extension WhereNonNullX<T> on Iterable<T?> {
  Iterable<T> get whereNonNull {
    return _whereNonNullIterable(this);
  }
}

extension WhereNonNullNullableX<T> on Iterable<T?>? {
  Iterable<T> get whereNonNull {
    final strongThis = this;
    if (strongThis == null) return [];
    return strongThis.whereNonNull;
  }
}
