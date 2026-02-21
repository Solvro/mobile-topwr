import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../config/map_view_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../map_view/controllers/controllers_set.dart";
import "../map_view/widgets/map_config.dart";
import "../parkings/parkings_view/widgets/parkings_icons.icons.dart";

class NavigateButton<T extends GoogleNavigable> extends ConsumerWidget {
  const NavigateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: MapViewBottomSheetConfig.horizontalPadding - 12),
      child: TextButton.icon(
        icon: Icon(ParkingsIcons.map_nav, color: context.colorScheme.primary, size: 16),
        onPressed: ref.watch(context.activeMarkerController<T>().notifier).launchLink,
        style: TextButton.styleFrom(padding: const EdgeInsets.all(12)),
        label: Text(
          context.localize.navigate,
          style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.primary),
          textScaler: context.textScaler.clamp(maxScaleFactor: 1.5),
        ),
      ),
    );
  }
}
