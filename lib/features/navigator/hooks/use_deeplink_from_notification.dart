import "dart:async";

import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "../../../firebase_init.dart";
import "../../../utils/launch_url_util.dart";

void _handleNotificationRoute(WidgetRef ref, RemoteMessage message, bool isDisposed) {
  if (isDisposed) return;

  final routePath = message.data["route"] as String?;

  if (routePath != null && routePath.isNotEmpty) {
    unawaited(ref.launch(routePath));
  }
}

/// Hook to listen for push notification taps and handle auto_route navigation
void useDeeplinkFromNotificationListener(WidgetRef ref) {
  final disposedRef = useRef(false);
  useEffect(() {
    StreamSubscription<RemoteMessage>? messagingSubscription;
    WidgetsFlutterBinding.ensureInitialized();
    unawaited(
      firebaseInit().then((_) async {
        // 1. App launched from terminated state via notification tap
        final message = await FirebaseMessaging.instance.getInitialMessage();
        if (message != null && !disposedRef.value) {
          _handleNotificationRoute(ref, message, false);
        }

        if (disposedRef.value) return;

        // 2. App opened from background state via notification tap
        messagingSubscription = FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
            if (!disposedRef.value) _handleNotificationRoute(ref, message, false);
          },
        );
      }),
    );

    // Cleanup subscription
    return () {
      disposedRef.value = true;
      unawaited(messagingSubscription?.cancel());
    };
  }, []);
}
