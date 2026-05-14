import "package:clarity_flutter/clarity_flutter.dart";
import "package:flutter/widgets.dart";

import "app_analytics.dart";

AnalyticsDriver createPlatformAnalyticsDriver() => NativeClarityAnalyticsDriver();

class NativeClarityAnalyticsDriver implements AnalyticsDriver {
  ClarityConfig? _config;

  bool get _isInitialized => _config != null;

  @override
  Future<void> initialize({required String projectId}) async {
    _config = ClarityConfig(projectId: projectId, logLevel: LogLevel.None);
  }

  @override
  Widget wrapApp({required Widget app}) {
    final config = _config;
    if (config == null) {
      return app;
    }

    return ClarityWidget(clarityConfig: config, app: app);
  }

  @override
  void trackEvent(String eventName) {
    if (!_isInitialized) {
      return;
    }

    Clarity.sendCustomEvent(eventName);
  }

  @override
  void setCustomTag(String key, String value) {
    if (!_isInitialized) {
      return;
    }

    Clarity.setCustomTags(key, [value]);
  }

  @override
  void setCustomUserId(String userId) {
    if (!_isInitialized) {
      return;
    }

    Clarity.setCustomUserId(userId);
  }
}
