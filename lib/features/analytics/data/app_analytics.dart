import "package:flutter/widgets.dart";

import "app_analytics_driver.dart";

final appAnalytics = AppAnalytics._(createAnalyticsDriver());

abstract interface class AnalyticsDriver {
  Future<void> initialize({required String projectId});

  Widget wrapApp({required Widget app});

  void trackEvent(String eventName);

  void setCustomTag(String key, String value);

  void setCustomUserId(String userId);
}

class AppAnalytics {
  AppAnalytics._(this._driver);

  final AnalyticsDriver _driver;

  Future<void> initialize({required String projectId}) {
    return _driver.initialize(projectId: projectId);
  }

  Widget wrapApp({required Widget app}) {
    return _driver.wrapApp(app: app);
  }

  void trackEvent(String eventName) {
    _driver.trackEvent(eventName);
  }

  void setCustomTag(String key, String value) {
    _driver.setCustomTag(key, value);
  }

  void setCustomUserId(String userId) {
    _driver.setCustomUserId(userId);
  }
}
