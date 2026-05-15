import "package:flutter/widgets.dart";

import "app_analytics.dart";

AnalyticsDriver createPlatformAnalyticsDriver() => const NoopAnalyticsDriver();

class NoopAnalyticsDriver implements AnalyticsDriver {
  const NoopAnalyticsDriver();

  @override
  Future<void> initialize({required String projectId}) async {}

  @override
  Widget wrapApp({required Widget app}) => app;

  @override
  void trackEvent(String eventName) {}

  @override
  void setCustomTag(String key, String value) {}

  @override
  void setCustomUserId(String userId) {}
}
