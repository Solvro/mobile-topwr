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
    final items = <String>{};

    if (modes.contains(const MotorImpairment())) {
      items.addAll(getCommentsListForMotorImpairment());
    }
    if (modes.contains(const Blind())) {
      items.addAll(getCommentsListForBlind());
    }
    if (modes.contains(const LowVision())) {
      items.addAll(getCommentsListForLowVision());
    }
    if (modes.contains(const SensorySensitivity())) {
      items.addAll(getCommentsListForSensorySensitivity());
    }
    if (modes.contains(const CognitiveImpairment())) {
      items.addAll(getCommentsListForCognitiveImpairment());
    }
    if (modes.contains(const HearingImpairment())) {
      items.addAll(getCommentsListForHearingImpairment());
    }

    return items.toIList();
  }

  Widget getIconForModes(ISet<ModeWithKey> modes) {
    final modesCount = modes.length;

    if (modesCount != 1) {
      return const SizedBox(
        height: 17,
        width: 28,
        child: Icon(Icons.accessibility),
      );
    }

    final currentMode = modes.first;
    switch (currentMode) {
      case MotorImpairment():
        return SvgPicture.asset(
          Assets.svg.digitalGuide.accessibilityAlerts.movementDysfunction,
          height: 17,
          width: 28,
        );
      case Blind():
        return SvgPicture.asset(
          Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
          height: 17,
          width: 28,
        );
      case LowVision():
        return SvgPicture.asset(
          Assets.svg.digitalGuide.accessibilityAlerts.visuallyImpaired,
          height: 17,
          width: 28,
        );
      case SensorySensitivity():
        return SvgPicture.asset(
          Assets.svg.digitalGuide.accessibilityAlerts.sensorySensitivity,
          height: 17,
          width: 28,
        );
      case CognitiveImpairment():
        return SvgPicture.asset(
          Assets.svg.digitalGuide.accessibilityAlerts.cognitiveDifficulties,
          height: 17,
          width: 28,
        );
      case HearingImpairment():
        return SvgPicture.asset(
          Assets.svg.digitalGuide.accessibilityAlerts.hearingDysfunction,
          height: 17,
          width: 28,
        );
    }
  }
}
