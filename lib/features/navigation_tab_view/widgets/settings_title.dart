import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../navigator/utils/navigation_commands.dart";
import "navigation_tile.dart";

class SettingsTitle extends ConsumerWidget {
  const SettingsTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationTile(
      onTap: () async => ref.navigateSettings(),
      title: context.localize.settings,
      icon: Icons.settings,
    ); // NavigationTitle
  }
}
