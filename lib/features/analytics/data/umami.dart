import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:umami_tracker/umami_tracker.dart";

import "../../../config/env.dart";
import "../../navigator/navigation_stack.dart";
import "umami_events.dart";

part "umami.g.dart";

@Riverpod(keepAlive: true)
Future<UmamiTracker> umami(Ref ref) async {
  return createUmamiTracker(url: Env.umamiUrl, id: Env.umamiId, hostname: "com.solvro.topwr");
}

/// utils extensions
extension UmamiTrackEventX on WidgetRef {
  Future<void> trackEvent(UmamiEvents event, {String? value}) async {
    final umami = await read(umamiProvider.future);
    final currentRoute = read(currentRouteProvider);
    await umami.trackEvent(eventType: event.toJson(), eventValue: value, screenName: currentRoute?.settings.name);
  }

  Future<void> trackScreen(String screenName, {String? referrer}) async {
    final umami = await read(umamiProvider.future);
    await umami.trackScreenView(screenName, referrer: referrer);
  }
}
