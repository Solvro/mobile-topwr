import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "is_following_controller.dart";

class MyLocationButton extends ConsumerWidget {
  const MyLocationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Transform.scale(
      scale: context.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.5).scale(1),
      child: FloatingActionButton.small(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: context.colorTheme.orangePomegranade,
        onPressed: ref.watch(isFollowingCurrentLocationControllerProvider.notifier).buttonClicked,
        child: Icon(
          semanticLabel: context.localize.my_location,
          Icons.my_location,
          color: context.colorTheme.whiteSoap,
        ),
      ),
    );
  }
}
