import "package:flutter/material.dart";

import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";

class ReversedLabel extends StatelessWidget {
  const ReversedLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 0.1);
    return Padding(
      padding: EdgeInsets.only(bottom: scaler.scale(25), right: scaler.scale(2)),
      child: RotatedBox(
        quarterTurns: -1,
        child: ExcludeSemantics(
          child: Text(context.localize.freePlaces, style: context.iParkingTheme.chart, textAlign: TextAlign.start),
        ),
      ),
    );
  }
}
