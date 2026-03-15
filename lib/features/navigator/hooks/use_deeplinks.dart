import "package:hooks_riverpod/hooks_riverpod.dart";

import "use_deeplink_from_notification.dart";
import "use_deeplink_listener.dart";

void useDeeplinks(WidgetRef ref) {
  useDeeplinkListener(ref);
  useDeeplinkFromNotificationListener(ref);
}
