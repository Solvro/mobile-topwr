import "package:flutter/material.dart";

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
          Text(context.localize.change_report_title),
          const SizedBox(height: 8),
          ElevatedButton(
            // TODO(Bartosh): handle action
            onPressed: () {},
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
              context.localize.change_report_button,
              style: TextStyle(color: context.colorTheme.whiteSoap),
            ),
          ),
        ],
      ),
    );
  }
}
