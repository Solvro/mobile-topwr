import "dart:async";
import "package:flutter_riverpod/flutter_riverpod.dart";

extension RefIntervalRefreshX on Ref {
  void setRefresh(Duration interval) {
    final timer = Timer.periodic(
      interval,
      (t) => invalidateSelf(),
    );
    onDispose(timer.cancel);
  }
}
