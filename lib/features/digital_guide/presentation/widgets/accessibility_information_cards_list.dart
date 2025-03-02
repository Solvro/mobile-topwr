import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../gen/assets.gen.dart";
import "../../../../../utils/context_extensions.dart";
import "../../tabs/accessibility_dialog/data/active_accessibility_modes_repository.dart";
import "../../tabs/accessibility_dialog/data/modes.dart";
import "accessibility_information_card.dart";

// these are levels; they are always obligatory
typedef AccessibilityInformationLevelsInput =
    ({
      int accessibilityLevelForBlind,
      int accessibilityLevelForVisuallyImpaired,
      int accessibilityLevelForMotorDisability,
      int accessibilityLevelForCognitiveDifficulties,
      int accessibilityLevelForHardOfHearing,
      int accessibilityLevelForHighSensorySensitivity,
    });

// Sometimes we might have comments for each level; they are optional; if they are present, we show them, and if not, we construct the text from the levels
typedef AccessibilityInformationOptionalCommentsInput =
    ({
      String? commentForBlind,
      String? commentForVisuallyImpaired,
      String? commentForMotorDisability,
      String? commentForCognitiveDifficulties,
      String? commentForHardOfHearing,
      String? commentForHighSensorySensitivity,
    });

class AccessibilityInformationCardsList extends ConsumerWidget {
  const AccessibilityInformationCardsList({
    super.key,
    required this.prefix,
    required this.accessibilityLevelType,
    required this.accLevels,
    this.accComments,
    this.padding = EdgeInsets.zero,
  });

  final AccessibilityInformationLevelsInput accLevels;
  final AccessibilityInformationOptionalCommentsInput? accComments;
  final String prefix;
  final String Function(String) accessibilityLevelType;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentModesAsync = ref.watch(activeAccessibilityModesRepositoryProvider);

    return currentModesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text("Error: $error")),
      data: (currentModes) {
        if (currentModes.isEmpty) {
          return const SizedBox.shrink();
        }

        final cards = {
          // Card for blind accessibility
          const Blind(): AccessibilityInformationCard(
            icon: Assets.svg.digitalGuide.accessibilityAlerts.blindProfile,
            color: DigitalGuideConfig.accessibilityLevelColors[accLevels.accessibilityLevelForBlind],
            text:
                accComments?.commentForBlind ??
                context.localize.accessibility_card_information(
                  prefix,
                  accessibilityLevelType(accLevels.accessibilityLevelForBlind.toString()),
                  context.localize.people_blind,
                ),
          ),

          // Card for visually impaired
          const LowVision(): AccessibilityInformationCard(
            icon: Assets.svg.digitalGuide.accessibilityAlerts.visuallyImpaired,
            color: DigitalGuideConfig.accessibilityLevelColors[accLevels.accessibilityLevelForVisuallyImpaired],
            text:
                accComments?.commentForVisuallyImpaired ??
                context.localize.accessibility_card_information(
                  prefix,
                  accessibilityLevelType(accLevels.accessibilityLevelForVisuallyImpaired.toString()),
                  context.localize.people_visually_impaired,
                ),
          ),

          // Card for motor disabilities
          const MotorImpairment(): AccessibilityInformationCard(
            icon: Assets.svg.digitalGuide.accessibilityAlerts.movementDysfunction,
            color: DigitalGuideConfig.accessibilityLevelColors[accLevels.accessibilityLevelForMotorDisability],
            text:
                accComments?.commentForMotorDisability ??
                context.localize.accessibility_card_information(
                  prefix,
                  accessibilityLevelType(accLevels.accessibilityLevelForMotorDisability.toString()),
                  context.localize.people_with_motor_disability,
                ),
          ),

          // Card for cognitive difficulties
          const CognitiveImpairment(): AccessibilityInformationCard(
            icon: Assets.svg.digitalGuide.accessibilityAlerts.cognitiveDifficulties,
            color: DigitalGuideConfig.accessibilityLevelColors[accLevels.accessibilityLevelForCognitiveDifficulties],
            text:
                accComments?.commentForCognitiveDifficulties ??
                context.localize.accessibility_card_information(
                  prefix,
                  accessibilityLevelType(accLevels.accessibilityLevelForCognitiveDifficulties.toString()),
                  context.localize.people_with_cognitive_difficulties,
                ),
          ),

          // Card for hard of hearing
          const HearingImpairment(): AccessibilityInformationCard(
            icon: Assets.svg.digitalGuide.accessibilityAlerts.hearingDysfunction,
            color: DigitalGuideConfig.accessibilityLevelColors[accLevels.accessibilityLevelForHardOfHearing],
            text:
                accComments?.commentForHardOfHearing ??
                context.localize.accessibility_card_information(
                  prefix,
                  accessibilityLevelType(accLevels.accessibilityLevelForHardOfHearing.toString()),
                  context.localize.people_with_hard_of_hearing,
                ),
          ),

          // Card for high sensory sensitivity
          const SensorySensitivity(): AccessibilityInformationCard(
            icon: Assets.svg.digitalGuide.accessibilityAlerts.sensorySensitivity,
            color: DigitalGuideConfig.accessibilityLevelColors[accLevels.accessibilityLevelForHighSensorySensitivity],
            text:
                accComments?.commentForHighSensorySensitivity ??
                context.localize.accessibility_card_information(
                  prefix,
                  accessibilityLevelType(accLevels.accessibilityLevelForHighSensorySensitivity.toString()),
                  context.localize.people_with_high_sensory_sensitivity,
                ),
          ),
        };

        final widgets = currentModes.map((mode) => cards[mode]).toList();

        return Padding(
          padding: padding,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widgets.length,
            itemBuilder: (context, index) => widgets[index],
            separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightSmall),
            shrinkWrap: true,
          ),
        );
      },
    );
  }
}
