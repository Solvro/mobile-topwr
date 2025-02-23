import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../theme/app_theme.dart";
import "../../../../../config/ui_config.dart";
import "../../../../../utils/context_extensions.dart";
import "../../tabs/accessibility_dialog/data/active_accessibility_modes_repository.dart";
import "../../utils/accessibility_comments_manager.dart";
import "bullet_list.dart";

class AccessibilityProfileCard extends ConsumerWidget {
  final AccessibilityCommentsManager accessibilityCommentsManager;

  const AccessibilityProfileCard({
    super.key,
    required this.accessibilityCommentsManager,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentModesAsync =
        ref.watch(activeAccessibilityModesRepositoryProvider);

    return currentModesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text("Error: $error")),
      data: (currentModes) {
        if (currentModes.isEmpty) {
          return const SizedBox.shrink();
        }

        final itemList =
            accessibilityCommentsManager.getCommentsForModes(currentModes);
        final icon = accessibilityCommentsManager.getIconForModes(currentModes);

        return Padding(
          padding: const EdgeInsets.only(top: DigitalGuideConfig.paddingBig),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      DigitalGuideConfig.borderRadiusMedium,),
                  border: Border.all(color: context.colorTheme.blackMirage),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(DigitalGuideConfig.paddingMedium),
                  child: BulletList(items: itemList),
                ),
              ),
              Positioned(
                top: -15,
                left: 20,
                child: ColoredBox(
                  color: context.colorTheme.greyLight,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(DigitalGuideConfig.paddingSmall),
                    child: Row(
                      children: [
                        Text(
                          context.localize.accessibility_profile,
                          style: context.textTheme.title,
                        ),
                        const SizedBox(width: DigitalGuideConfig.heightSmall),
                        icon,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
