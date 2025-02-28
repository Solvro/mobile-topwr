import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class ReversedLabel extends StatelessWidget {
  const ReversedLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25, right: 2),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(context.localize.freePlaces, style: context.iParkingTheme.chart, textAlign: TextAlign.start),
      ),
    );
  }
}
