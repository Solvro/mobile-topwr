import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:logger/logger.dart";
import "package:url_launcher/url_launcher.dart";

import "../config/url_config.dart";
import "../features/analytics/data/clarity.dart";
import "../features/analytics/data/clarity_events.dart";
import "../features/navigator/utils/navigation_commands.dart";
import "../theme/colors.dart";
import "context_extensions.dart";

extension LaunchUrlUtilX on WidgetRef? {
  Future<bool> launch(String uriStr) async {
    if (this != null && uriStr.startsWith(UrlConfig.topwrUrl)) {
      final urlWithoutDomain = uriStr.split(UrlConfig.topwrUrl).last;
      unawaited(
        this!.navigateNamedUri(
          urlWithoutDomain.endsWith("/") // remove trailing slash
              ? urlWithoutDomain.substring(0, urlWithoutDomain.length - 1)
              : urlWithoutDomain,
        ),
      );
      return true;
    }
    final uri = Uri.parse(uriStr);
    if (await canLaunchUrl(uri)) {
      unawaited(this?.trackEvent(ClarityEvents.goToExternalLink, value: uriStr));
      if (uri.host.contains("dostepnosc.pwr.edu.pl")) {
        unawaited(this?.trackEvent(ClarityEvents.openExternalAccessibilityDeclarationWebsite, value: uriStr));
      }
      return launchUrl(uri);
    }

    final String toastMsg = this?.context.localize.report_change_error_toast_message ?? "";
    if (toastMsg.isNotEmpty) {
      Logger().e("launchUrlUtil failed: $toastMsg URI: $uriStr  ");
      await Fluttertoast.showToast(
        msg: toastMsg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsConsts.greyLight,
        textColor: ColorsConsts.blackMirage,
      );
    }

    return false;
  }
}
