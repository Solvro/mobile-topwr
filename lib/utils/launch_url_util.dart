import "dart:async";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:url_launcher/url_launcher.dart";

import "../config/url_config.dart";
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
      return launchUrl(uri);
    }

    final String toastMsg = this?.context.localize.report_change_error_toast_message ?? "";

    if (toastMsg.isNotEmpty) {
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
