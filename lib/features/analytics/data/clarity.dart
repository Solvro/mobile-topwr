import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_analytics.dart";
import "clarity_events.dart";

/// utils extensions
extension TrackEventWidgetRefX on WidgetRef {
  Future<void> trackEvent(ClarityEvents event, {String? value}) async {
    appAnalytics.trackEvent(event.toJson());
  }
}

extension TrackEventRefX on Ref {
  Future<void> trackEvent(ClarityEvents event, {String? value}) async {
    appAnalytics.trackEvent(event.toJson());
  }
}
