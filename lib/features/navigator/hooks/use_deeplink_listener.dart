import "dart:async";

import "package:app_links/app_links.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../config/url_config.dart";
import "../../../utils/launch_url_util.dart";

/// hook to listen for deeplinks and handle them using ref.launch
void useDeeplinkListener(WidgetRef ref) {
  final appLinks = useMemoized(AppLinks.new);

  useEffect(() {
    // handle initial link when app is opened from a deeplink
    unawaited(
      appLinks.getInitialLink().then((initialUri) async {
        if (initialUri != null) {
          final uriString = initialUri.toString();
          if (uriString.startsWith(UrlConfig.topwrUrl)) {
            await ref.launch(uriString);
          }
        }
      }),
    );

    // listen to all incoming links (subsequent links after app is already running)
    final linkSubscription = appLinks.uriLinkStream.listen((uri) {
      final uriString = uri.toString();
      if (uriString.startsWith(UrlConfig.topwrUrl)) {
        unawaited(ref.launch(uriString));
      }
    });

    return linkSubscription.cancel;
  }, []);
}
