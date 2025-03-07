import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/launch_url_util.dart";

class ReportChangeButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: AppWidgetsConfig.paddingMedium,
      child: Column(
        children: [
          Text(context.localize.report_change_title),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final emailUrl =
                  "mailto:${context.localize.report_change_email}?subject=${Uri.encodeComponent(context.localize.report_change_subject)}";
              unawaited(ref.launch(emailUrl));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorTheme.orangePomegranade,
              padding: AppWidgetsConfig.paddingMedium,
              minimumSize: const Size(144, 40),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppWidgetsConfig.borderRadiusMedium)),
            ),
            child: Text(context.localize.report_change_button, style: TextStyle(color: context.colorTheme.whiteSoap)),
          ),
        ],
      ),
    );
  }
}
