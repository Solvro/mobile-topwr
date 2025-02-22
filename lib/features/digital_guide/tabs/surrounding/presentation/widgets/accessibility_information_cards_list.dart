import "package:flutter/material.dart";

import "../../../../../../../config/ui_config.dart";
import "../../../../../../../gen/assets.gen.dart";
import "../../../../../../../utils/context_extensions.dart";
import "../../../../presentation/widgets/accessibility_information_card.dart";

// these are levels; they are always obligatory
typedef AccessibilityInformationLevelsInput = ({
  int accessibilityLevelForBlind,
  int accessibilityLevelForVisuallyImpaired,
  int accessibilityLevelForMotorDisability,
  int accessibilityLevelForCognitiveDifficulties,
  int accessibilityLevelForHardOfHearing,
  int accessibilityLevelForHighSensorySensitivity
});

// Sometimes we might have comments for each level; they are optional; if they are present, we show them, and if not, we construct the text from the levels
typedef AccessibilityInformationOptionalCommentsInput = ({
  String? commentForBlind,
  String? commentForVisuallyImpaired,
  String? commentForMotorDisability,
  String? commentForCognitiveDifficulties,
  String? commentForHardOfHearing,
  String? commentForHighSensorySensitivity
});

class AccessibilityInformationCardsList extends StatelessWidget {
  const AccessibilityInformationCardsList({
    super.key,
    required this.accLevels,
    this.accComments,
  });

  final AccessibilityInformationLevelsInput accLevels;
  final AccessibilityInformationOptionalCommentsInput? accComments;

  @override
  Widget build(BuildContext context) {
    final widgets = [
      // Card for blind accessibility
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
        color: DigitalGuideConfig
            .accessibilityLevelColors[accLevels.accessibilityLevelForBlind],
        text: accComments?.commentForBlind ??
            context.localize.accessibility_card_information(
              context.localize.surroundings,
              context.localize.accessibility_level_neuter(
                accLevels.accessibilityLevelForBlind.toString(),
              ),
              context.localize.people_blind,
            ),
      ),

      // Card for visually impaired
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.visuallyImpaired,
        color: DigitalGuideConfig.accessibilityLevelColors[
            accLevels.accessibilityLevelForVisuallyImpaired],
        text: accComments?.commentForVisuallyImpaired ??
            context.localize.accessibility_card_information(
              context.localize.surroundings,
              context.localize.accessibility_level_neuter(
                accLevels.accessibilityLevelForVisuallyImpaired.toString(),
              ),
              context.localize.people_visually_impaired,
            ),
      ),

      // Card for motor disabilities
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.movementDysfunction,
        color: DigitalGuideConfig.accessibilityLevelColors[
            accLevels.accessibilityLevelForMotorDisability],
        text: accComments?.commentForMotorDisability ??
            context.localize.accessibility_card_information(
              context.localize.surroundings,
              context.localize.accessibility_level_neuter(
                accLevels.accessibilityLevelForMotorDisability.toString(),
              ),
              context.localize.people_with_motor_disability,
            ),
      ),

      // Card for cognitive difficulties
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.cognitiveDifficulties,
        color: DigitalGuideConfig.accessibilityLevelColors[
            accLevels.accessibilityLevelForCognitiveDifficulties],
        text: accComments?.commentForCognitiveDifficulties ??
            context.localize.accessibility_card_information(
              context.localize.surroundings,
              context.localize.accessibility_level_neuter(
                accLevels.accessibilityLevelForCognitiveDifficulties.toString(),
              ),
              context.localize.people_with_cognitive_difficulties,
            ),
      ),

      // Card for hard of hearing
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.hearingDysfunction,
        color: DigitalGuideConfig.accessibilityLevelColors[
            accLevels.accessibilityLevelForHardOfHearing],
        text: accComments?.commentForHardOfHearing ??
            context.localize.accessibility_card_information(
              context.localize.surroundings,
              context.localize.accessibility_level_neuter(
                accLevels.accessibilityLevelForHardOfHearing.toString(),
              ),
              context.localize.people_with_hard_of_hearing,
            ),
      ),

      // Card for high sensory sensitivity
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.sensorySensitivity,
        color: DigitalGuideConfig.accessibilityLevelColors[
            accLevels.accessibilityLevelForHighSensorySensitivity],
        text: accComments?.commentForHighSensorySensitivity ??
            context.localize.accessibility_card_information(
              context.localize.surroundings,
              context.localize.accessibility_level_neuter(
                accLevels.accessibilityLevelForHighSensorySensitivity
                    .toString(),
              ),
              context.localize.people_with_high_sensory_sensitivity,
            ),
      ),
    ];

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
      separatorBuilder: (context, index) => const SizedBox(
        height: DigitalGuideConfig.heightSmall,
      ),
      shrinkWrap: true,
    );
  }
}
