import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../navigator/utils/navigation_commands.dart";
import "navigation_tile.dart";

class SksTile extends ConsumerWidget {
  const SksTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationTile(
      onTap: () async {
        unawaited(HapticFeedback.selectionClick());
        await ref.navigateToSksMenu();
      },
      title: context.localize.sks_menu,
      icon: Icons.restaurant,
    );
  }
}
