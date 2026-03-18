import "dart:async";

import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../features/notifications/data/repository/notifications_repository.dart";
import "../../../features/sks/sks_menu/data/repository/sks_menu_repository.dart";
import "../../../utils/launch_url_util.dart";

Future<void> _handleNotificationRoute(WidgetRef ref, RemoteMessage message, ObjectRef<bool> disposedRef) async {
  if (disposedRef.value) return;

  final routePath = message.data["route"] as String?;

  if (routePath != null && routePath.isNotEmpty) {
    // When opening via notification, always clear notifications cache.
    await ref.read(notificationsRepositoryProvider.notifier).clearCache();

    // Clear SKS menu cache only for the `/sks-menu` deeplink.
    final uri = Uri.tryParse(routePath);
    final isSksMenu = uri != null && uri.path == "/sks-menu";
    if (isSksMenu) {
      await ref.read(sksMenuRepositoryProvider.notifier).clearCache();
    }

    if (disposedRef.value) return;
    unawaited(ref.launch(routePath));
  }
}

/// Hook to listen for push notification taps and handle auto_route navigation
void useDeeplinkFromNotificationListener(WidgetRef ref) {
  final disposedRef = useRef(false);
  useEffect(() {
    StreamSubscription<RemoteMessage>? messagingSubscription;
    unawaited(() async {
      if (kDebugMode) {
        return;
      }

      // 1. App launched from terminated state via notification tap
      final message = await FirebaseMessaging.instance.getInitialMessage();
      if (message != null && !disposedRef.value) {
        unawaited(_handleNotificationRoute(ref, message, disposedRef));
      }

      if (disposedRef.value) return;

      // 2. App opened from background state via notification tap
      messagingSubscription = FirebaseMessaging.onMessageOpenedApp.listen((message) {
        if (!disposedRef.value) unawaited(_handleNotificationRoute(ref, message, disposedRef));
      });
    }());

    // Cleanup subscription
    return () {
      disposedRef.value = true;
      unawaited(messagingSubscription?.cancel());
    };
  }, []);
}
