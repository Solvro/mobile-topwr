extension MoreGettersX<T> on List<T> {
  T? get lastOrNull => isNotEmpty ? last : null;

  T? get preLastOrNull => length > 1 ? this[length - 2] : null;

  T? get prePreLastOrNull => length > 2 ? this[length - 3] : null;
}
