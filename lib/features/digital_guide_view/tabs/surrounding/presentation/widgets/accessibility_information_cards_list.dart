import "package:flutter/material.dart";

import "../../../../../../../config/ui_config.dart";
import "../../../../../../../gen/assets.gen.dart";
import "../../../../../../../utils/context_extensions.dart";
import "../../../../presentation/widgets/accessibility_information_card.dart";
import "../../data/models/surrounding_response_extended.dart";

// THIS WIDGET IS TEMPORARY BECAUSE IT WILL BE SHOWN CONDITIONALLY - THINGS ARE HARDCODED FOR NOW

class AccessibilityInformationCardsList extends StatelessWidget {
  const AccessibilityInformationCardsList({
    super.key,
    required this.surroundingResponse,
  });

  final SurroundingResponseExtended surroundingResponse;

  @override
  Widget build(BuildContext context) {
    final widgets = [
      // Card for blind accessibility
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
        color: DigitalGuideConfig.accessibilityLevelColors[
            surroundingResponse.accessibilityLevelForBlind],
        text: context.localize.accessibility_card_information(
          context.localize.surroundings,
          context.localize.accessibility_level_neuter(
            surroundingResponse.accessibilityLevelForBlind.toString(),
          ),
          context.localize.people_blind,
        ),
      ),

      const SizedBox(
        height: DigitalGuideConfig.heightSmall,
      ),

      // Card for visually impaired
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.visuallyImpaired,
        color: DigitalGuideConfig.accessibilityLevelColors[
            surroundingResponse.accessibilityLevelForVisuallyImpaired],
        text: context.localize.accessibility_card_information(
          context.localize.surroundings,
          context.localize.accessibility_level_neuter(
            surroundingResponse.accessibilityLevelForVisuallyImpaired
                .toString(),
          ),
          context.localize.people_visually_impaired,
        ),
      ),

      const SizedBox(
        height: DigitalGuideConfig.heightSmall,
      ),

      // Card for motor disabilities
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.movementDysfunction,
        color: DigitalGuideConfig.accessibilityLevelColors[
            surroundingResponse.accessibilityLevelForMotorDisability],
        text: context.localize.accessibility_card_information(
          context.localize.surroundings,
          context.localize.accessibility_level_neuter(
            surroundingResponse.accessibilityLevelForMotorDisability.toString(),
          ),
          context.localize.people_with_motor_disability,
        ),
      ),

      const SizedBox(
        height: DigitalGuideConfig.heightSmall,
      ),

      // Card for cognitive difficulties
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.cognitiveDifficulties,
        color: DigitalGuideConfig.accessibilityLevelColors[
            surroundingResponse.accessibilityLevelForCognitiveDifficulties],
        text: context.localize.accessibility_card_information(
          context.localize.surroundings,
          context.localize.accessibility_level_neuter(
            surroundingResponse.accessibilityLevelForCognitiveDifficulties
                .toString(),
          ),
          context.localize.people_with_cognitive_difficulties,
        ),
      ),

      const SizedBox(
        height: DigitalGuideConfig.heightSmall,
      ),

      // Card for hard of hearing
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.hearingDysfunction,
        color: DigitalGuideConfig.accessibilityLevelColors[
            surroundingResponse.accessibilityLevelForHardOfHearing],
        text: context.localize.accessibility_card_information(
          context.localize.surroundings,
          context.localize.accessibility_level_neuter(
            surroundingResponse.accessibilityLevelForHardOfHearing.toString(),
          ),
          context.localize.people_with_hard_of_hearing,
        ),
      ),

      const SizedBox(
        height: DigitalGuideConfig.heightSmall,
      ),

      // Card for high sensory sensitivity
      AccessibilityInformationCard(
        icon: Assets.svg.digitalGuide.accessibilityAlerts.sensorySensitivity,
        color: DigitalGuideConfig.accessibilityLevelColors[
            surroundingResponse.accessibilityLevelForHighSensorySensitivity],
        text: context.localize.accessibility_card_information(
          context.localize.surroundings,
          context.localize.accessibility_level_neuter(
            surroundingResponse.accessibilityLevelForHighSensorySensitivity
                .toString(),
          ),
          context.localize.people_with_high_sensory_sensitivity,
        ),
      ),
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widgets.length,
      itemBuilder: (context, index) => widgets[index],
      shrinkWrap: true,
    );
  }
}
