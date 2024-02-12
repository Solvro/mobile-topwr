class WhereNonNullIterable<T> extends Iterable<T> {
  final Iterable<T?> _source;

  WhereNonNullIterable(this._source);

  @override
  Iterator<T> get iterator => _WhereNonNullIterator<T>(_source);
}

class _WhereNonNullIterator<T> implements Iterator<T> {
  final Iterator<T?> _sourceIterator;

  _WhereNonNullIterator(Iterable<T?> source)
      : _sourceIterator = source.iterator;

  @override
  T get current {
    return _sourceIterator.current as T;
  }

  @override
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
  Iterable<T> get whereNonNull {
    return WhereNonNullIterable(this);
  }
}

extension WhereNonNullExtNullable<T> on Iterable<T?>? {
  Iterable<T> get whereNonNull {
    if (this == null) return [];
    return this!.whereNonNull;
  }
}
