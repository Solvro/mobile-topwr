import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/map_view_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../parkings_view/widgets/parkings_icons.icons.dart";
import "../../controllers/controllers_set.dart";
import "../map_config.dart";

class NavigateButton<T extends GoogleNavigable> extends ConsumerWidget {
  const NavigateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        right: MapViewBottomSheetConfig.horizontalPadding - 3,
      ),
      child: TextButton.icon(
        icon: Icon(
          ParkingsIcons.map_nav,
          color: context.colorTheme.orangePomegranade,
          size: 16,
        ),
        onPressed:
            ref.watch(context.activeMarkerController<T>().notifier).launchLink,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        label: Text(
          context.localize.navigate,
          style: context.textTheme.boldBodyOrange,
        ),
      ),
    );
  }
}
