import "app_analytics.dart";
import "app_analytics_driver_stub.dart"
    if (dart.library.js_interop) "app_analytics_driver_web.dart"
    if (dart.library.io) "app_analytics_driver_native.dart";

AnalyticsDriver createAnalyticsDriver() => createPlatformAnalyticsDriver();
