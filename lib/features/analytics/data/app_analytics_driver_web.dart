import "package:clarity_web/clarity_web.dart";
import "package:flutter/widgets.dart";

import "app_analytics.dart";

AnalyticsDriver createPlatformAnalyticsDriver() => WebClarityAnalyticsDriver();

class WebClarityAnalyticsDriver implements AnalyticsDriver {
  final ClarityWeb _clarity = ClarityWeb.instance;

  var _isInitialized = false;

  @override
  Future<void> initialize({required String projectId}) async {
    await _clarity.initClarityWeb(projectId);
    _clarity.setIsCanvasMirrorActive(true);
    _isInitialized = _clarity.isInitialized;
  }

  @override
  Widget wrapApp({required Widget app}) => app;

  @override
  void trackEvent(String eventName) {
    if (!_isInitialized) {
      return;
    }

    _clarity.sendCustomEvent(eventName);
  }

  @override
  void setCustomTag(String key, String value) {
    if (!_isInitialized) {
      return;
    }

    _clarity.setCustomTag(key, value);
  }

  @override
  void setCustomUserId(String userId) {
    if (!_isInitialized) {
      return;
    }

    _clarity.setCustomUserId(userId);
  }
}
