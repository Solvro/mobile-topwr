import "dart:async";

import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";

class ReportChangeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppWidgetsConfig.paddingMedium,
      child: Column(
        children: [
          Text(context.localize.report_change_title),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              await openEmailApp(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorTheme.blueAzure,
              padding: AppWidgetsConfig.paddingMedium,
              minimumSize: const Size(144, 40),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppWidgetsConfig.borderRadiusMedium),
              ),
            ),
            child: Text(
              context.localize.report_change_button,
              style: TextStyle(color: context.colorTheme.whiteSoap),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> openEmailApp(BuildContext context) async {
  final errorMessageToast = context.localize.report_change_error_toast_message;
  final backgroundColorToast = context.colorTheme.greyLight;
  final textColorToast = context.colorTheme.blackMirage;

  final Uri emailUrl = Uri(
    scheme: "mailto",
    path: context.localize.report_change_email,
    query:
        "subject=${Uri.encodeComponent(context.localize.report_change_subject)}",
  );

  if (await canLaunchUrl(emailUrl) && !await launchUrl(emailUrl)) {
    unawaited(
      Fluttertoast.showToast(
        msg: errorMessageToast,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColorToast,
        textColor: textColorToast,
      ),
    );
  }
}
