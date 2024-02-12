class WhereNonNullIterable<T> extends Iterable<T> {
  final Iterable<T?> _source;

  /// A custom iterable class that filters out null elements from the source iterable.
  WhereNonNullIterable(this._source);

  @override
  Iterator<T> get iterator => _WhereNonNullIterator<T>(_source);
}

class _WhereNonNullIterator<T> implements Iterator<T> {
  final Iterator<T?> _sourceIterator;

  /// A private iterator class used by WhereNonNullIterable to iterate over non-null elements.
  _WhereNonNullIterator(Iterable<T?> source)
      : _sourceIterator = source.iterator;

  @override
  T get current {
    return _sourceIterator.current as T;
  }

  @override
  // Moves to the next non-null element in the iteration.
  bool moveNext() {
    while (_sourceIterator.moveNext()) {
      if (_sourceIterator.current != null) {
        return true;
      }
    }
    return false;
  }
}

extension WhereNonNullExt<T> on Iterable<T?> {
  /// filters out null elements using custom WhereNonNullIterable
  Iterable<T> get whereNonNull {
    return WhereNonNullIterable(this);
  }
}

extension WhereNonNullExtNullable<T> on Iterable<T?>? {
  /// filters out null elements using custom WhereNonNullIterable
  Iterable<T> get whereNonNull {
    if (this == null) return [];
    return this!.whereNonNull;
  }
}
