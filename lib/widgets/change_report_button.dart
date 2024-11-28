import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "../theme/colors.dart";
import "../utils/context_extensions.dart";

class ChangeReportButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          Text(context.localize.change_report_title),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsConsts.blueAzure,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ), 
            child: Text(context.localize.change_report_button, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }  
}
