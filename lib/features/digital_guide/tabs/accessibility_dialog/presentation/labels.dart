import "package:flutter/material.dart";

import "../../../../../utils/context_extensions.dart";
import "../data/modes.dart";

extension AccessibilityModeLocalizationX on AccessibilityMode {
  String localizedLabel(BuildContext context) {
    return switch (this) {
      MotorImpairment() => context.localize.motorImpairment,
      VisualImpairment() => context.localize.visualImpairment,
      Blind() => context.localize.blind,
      LowVision() => context.localize.lowVision,
      SensorySensitivity() => context.localize.sensorySensitivity,
      CognitiveImpairment() => context.localize.cognitiveImpairment,
    };
  }
}
