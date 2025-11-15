import "package:clarity_flutter/clarity_flutter.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "clarity_events.dart";

/// utils extensions
extension TrackEventWidgetRefX on WidgetRef {
  Future<void> trackEvent(ClarityEvents event, {String? value}) async {
    Clarity.sendCustomEvent(event.toJson());
  }
}

extension TrackEventRefX on Ref {
  Future<void> trackEvent(ClarityEvents event, {String? value}) async {
    Clarity.sendCustomEvent(event.toJson());
  }
}
