import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "is_following_controller.dart";

class MyLocationButton extends ConsumerWidget {
  const MyLocationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.small(
      tooltip: context.localize.my_location_button_tooltip,
      backgroundColor: context.colorTheme.whiteSoap,
      onPressed: ref.watch(isFollowingCurrentLocationControllerProvider.notifier).buttonClicked,
      child: Icon(Icons.my_location, color: context.colorTheme.orangePomegranade, size: 24),
    );
  }
}
