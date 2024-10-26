import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:url_launcher/url_launcher.dart";

import "../config/url_config.dart";
import "../features/navigator/utils/navigation_commands.dart";

extension LaunchUrlUtilX on WidgetRef? {
  Future<bool> launch(String uriStr) async {
    if (this != null && uriStr.startsWith(UrlConfig.topwrUrl)) {
      final urlWithoutDomain = uriStr.split(UrlConfig.topwrUrl).last;
      unawaited(
        this!.navigateNamedUri(urlWithoutDomain),
      );
      return true;
    }
    final uri = Uri.parse(uriStr);
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    }
    return false;
  }
}
