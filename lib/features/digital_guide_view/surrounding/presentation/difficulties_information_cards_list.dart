import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "../../general_info/presentation/widgets/difficulties_information_card.dart";
import "../data/models/surrounding_response.dart";
import "../../../../config/ui_config.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../../gen/assets.gen.dart";

// THIS WIDGET IS TEMPORARY BECAUSE IT WILL BE SHOWN CONDITIONALLY - THINGS ARE HARDCODED FOR NOW

class DifficultiesInformationCardsList extends StatelessWidget {
  const DifficultiesInformationCardsList({
    super.key,
    required this.surroundingResponse,
  });

  final SurroundingResponse surroundingResponse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card for blind accessibility
        DifficultiesInformationCard(
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

        // Card for visually impaired
        DifficultiesInformationCard(
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
        // Card for motor disabilities
        DifficultiesInformationCard(
          icon: Assets.svg.digitalGuide.accessibilityAlerts.movementDysfunction,
          color: DigitalGuideConfig.accessibilityLevelColors[
              surroundingResponse.accessibilityLevelForMotorDisability],
          text: context.localize.accessibility_card_information(
            context.localize.surroundings,
            context.localize.accessibility_level_neuter(
              surroundingResponse.accessibilityLevelForMotorDisability
                  .toString(),
            ),
            context.localize.people_with_motor_disability,
          ),
        ),
        // Card for cognitive difficulties
        DifficultiesInformationCard(
          icon:
              Assets.svg.digitalGuide.accessibilityAlerts.cognitiveDifficulties,
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

        // Card for hard of hearing
        DifficultiesInformationCard(
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

        // Card for high sensory sensitivity
        DifficultiesInformationCard(
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
      ],
    );
  }
}
