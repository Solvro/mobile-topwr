import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../../theme/app_theme.dart";
import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../tabs/accessibility_dialog/data/accessibility_mode_repository.dart";
import "../../tabs/accessibility_dialog/data/modes.dart";
import "bullet_list.dart";

typedef AcessibilityCommentsTuple = ({
  IList<String> motor,
  IList<String> blind,
  IList<String> lowVision,
  IList<String> sensor,
  IList<String> cognitive,
  IList<String> hearing,
});

class AccessibilityProfileCard extends ConsumerWidget {
  final AcessibilityCommentsTuple items;
  final String icon;

  const AccessibilityProfileCard({
    super.key,
    required this.items,
    required this.icon,
  });

  static const modes = <ModeWithKey>[
    MotorImpairment(),
    Blind(),
    LowVision(),
    SensorySensitivity(),
    CognitiveImpairment(),
    HearingImpairment(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeStatesTuples = modes.map(
        (mode) => (mode, ref.watch(accessibilityModeRepositoryProvider(mode))),);

    final Map<ModeWithKey, AsyncValue> modeStates = {
      for (final (mode, state) in modeStatesTuples) mode: state,
    };

    if (modeStates.values.any((state) => state.isLoading)) {
      return const Center(child: CircularProgressIndicator());
    }

    if (modeStates.values.any((state) => state.hasError)) {
      return Center(
        child: Text(
          "Error loading accessibility modes",
          style: context.textTheme.body,
        ),
      );
    }

    final Map<ModeWithKey, bool> enabledModes = {
      for (final entry in modeStates.entries)
        entry.key: (entry.value as AsyncData<bool>).value,
    };

    // if nothing is checked then return empty widget
    if (!enabledModes.values.anyIs(true)) {
      return const SizedBox.shrink();
    }

    final Set<String> itemsSet = {};

    if (enabledModes[const MotorImpairment()]!) {
      itemsSet.addAll(items.motor);
    }

    if (enabledModes[const Blind()]!) {
      itemsSet.addAll(items.blind);
    }

    if (enabledModes[const LowVision()]!) {
      itemsSet.addAll(items.lowVision);
    }

    if (enabledModes[const SensorySensitivity()]!) {
      itemsSet.addAll(items.sensor);
    }

    if (enabledModes[const CognitiveImpairment()]!) {
      itemsSet.addAll(items.cognitive);
    }

    if (enabledModes[const HearingImpairment()]!) {
      itemsSet.addAll(items.hearing);
    }

    final IList<String> itemsList = itemsSet.toIList();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(DigitalGuideConfig.borderRadiusMedium),
            border: Border.all(
              color: context.colorTheme.blackMirage,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
            child: BulletList(items: itemsList),
          ),
        ),
        Positioned(
          top: -15,
          left: 20,
          child: ColoredBox(
            color: context.colorTheme.greyLight,
            child: Padding(
              padding: const EdgeInsets.all(DigitalGuideConfig.paddingSmall),
              child: Row(
                children: [
                  Text(
                    context.localize.accessibility_profile,
                    style: context.textTheme.title,
                  ),
                  const SizedBox(width: DigitalGuideConfig.heightSmall),
                  SvgPicture.asset(
                    icon,
                    height: 17,
                    width: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
