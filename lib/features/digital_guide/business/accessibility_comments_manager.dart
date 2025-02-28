import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../gen/assets.gen.dart";
import "../tabs/accessibility_dialog/data/modes.dart";

abstract class AccessibilityCommentsManager {
  IList<String> getCommentsListForBlind();
  IList<String> getCommentsListForLowVision();
  IList<String> getCommentsListForCognitiveImpairment();
  IList<String> getCommentsListForMotorImpairment();
  IList<String> getCommentsListForSensorySensitivity();
  IList<String> getCommentsListForHearingImpairment();

  IList<String> getCommentsForModes(ISet<ModeWithKey> modes) {
    return {
      if (modes.contains(const MotorImpairment())) ...getCommentsListForMotorImpairment(),
      if (modes.contains(const Blind())) ...getCommentsListForBlind(),
      if (modes.contains(const LowVision())) ...getCommentsListForLowVision(),
      if (modes.contains(const SensorySensitivity())) ...getCommentsListForSensorySensitivity(),
      if (modes.contains(const CognitiveImpairment())) ...getCommentsListForCognitiveImpairment(),
      if (modes.contains(const HearingImpairment())) ...getCommentsListForHearingImpairment(),
    }.toIList();
  }

  Widget getIconForModes(ISet<ModeWithKey> modes) {
    final modesCount = modes.length;
    const double height = 17;
    const double width = 28;

    if (modesCount != 1) {
      return const SizedBox(height: height, width: width, child: Icon(Icons.accessibility));
    }

    final currentMode = modes.first;
    return switch (currentMode) {
      MotorImpairment() => SvgPicture.asset(
        Assets.svg.digitalGuide.accessibilityAlerts.movementDysfunction,
        height: height,
        width: width,
      ),
      Blind() => SvgPicture.asset(
        Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
        height: height,
        width: width,
      ),
      LowVision() => SvgPicture.asset(
        Assets.svg.digitalGuide.accessibilityAlerts.visuallyImpaired,
        height: height,
        width: width,
      ),
      SensorySensitivity() => SvgPicture.asset(
        Assets.svg.digitalGuide.accessibilityAlerts.sensorySensitivity,
        height: height,
        width: width,
      ),
      CognitiveImpairment() => SvgPicture.asset(
        Assets.svg.digitalGuide.accessibilityAlerts.cognitiveDifficulties,
        height: height,
        width: width,
      ),
      HearingImpairment() => SvgPicture.asset(
        Assets.svg.digitalGuide.accessibilityAlerts.hearingDysfunction,
        height: height,
        width: width,
      ),
    };
  }
}
