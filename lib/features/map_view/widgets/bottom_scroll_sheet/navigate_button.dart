import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../controllers/active_map_marker_cntrl.dart';
import '../../utils/google_maps_link_utils.dart';

class NavigateButton extends ConsumerWidget {
  const NavigateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 13),
      child: TextButton(
        onPressed: () {
          final active = ref.read(activeMapMarkerControllerProvider);
          if (active != null) GoogleMapsLinkUtils.navigateTo(active);
        },
        child: Text(
          context.localize?.navigate ?? "",
          style: context.textTheme.boldBodyOrange,
        ),
      ),
    );
  }
}
