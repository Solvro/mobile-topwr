import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/my_text_button.dart';
import '../../controllers/controllers_set.dart';
import '../../utils/google_maps_link_utils.dart';

class NavigateButton extends ConsumerWidget {
  const NavigateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        right: MapViewBottomSheetConfig.horizontalPadding - 3,
      ),
      child: MyTextButton(
        onClick: () {
          final active = ref.read(
            ref.read(mapControllersProvider).activeMarker,
          );
          if (active != null) GoogleMapsLinkUtils.navigateTo(active);
        },
        actionTitle: context.localize.navigate,
      ),
    );
  }
}
