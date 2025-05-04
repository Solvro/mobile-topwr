import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../theme/hex_color.dart";
import "../../../utils/launch_url_util.dart";
import "../../../widgets/my_alert_dialog.dart";
import "../../../widgets/my_error_widget.dart";
import "../repository/planner_advert_repository.dart";
import "planer_badge_dialog.dart";

class PlanerAdBadge extends ConsumerWidget {
  const PlanerAdBadge({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(plannerAdvertContentRepositoryProvider);
    return switch (state) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final PlannerAdvertContent value) => _BadgeContent(value),
      _ => const SizedBox.shrink(),
    };
  }
}

class _BadgeContent extends ConsumerWidget {
  const _BadgeContent(this.data);

  final PlannerAdvertContent data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!data.isEnabled) return const SizedBox.shrink();
    final textColor = data.textColor != null ? HexColor(data.textColor!) : context.colorTheme.blackMirage;
    final backgroundColor = data.backgroundColor != null ? HexColor(data.backgroundColor!) : null;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: OutlinedButton(
        onPressed: () async {
          await showCustomDialog(
            context: context,
            onConfirmTapped: (context) {
              unawaited(ref.launch(data.url!));
              Navigator.pop(context);
            },
            confirmText: "Czytaj więcej",
            dialogContent: PlanerBadgeDialogContent(data: data),
          );
        },
        style: OutlinedButton.styleFrom(
          shape: const CircleBorder(),
          side: const BorderSide(color: Colors.transparent),
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(8),
          elevation: 2,
        ),
        child: Icon(Icons.warning_rounded, color: textColor, size: 24),
      ),
    );
  }
}
