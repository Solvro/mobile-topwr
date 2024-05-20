Iterable<double> generateRange(
  double start,
  double stop, [
  double step = 1,
]) sync* {
  for (var i = start; i <= stop; i += step) {
    yield i;
  }
}
