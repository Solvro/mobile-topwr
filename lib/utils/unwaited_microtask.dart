import "dart:async";

/// Schedules a microtask to run asynchronously without waiting for its completion.
/// This is useful when you want to fire-and-forget an async operation.
void unwaitedMicrotask<T>(Future<T> Function() microtask) {
  unawaited(Future.microtask(microtask));
}
