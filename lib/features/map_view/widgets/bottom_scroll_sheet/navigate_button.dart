import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/my_text_button.dart';
import '../map_config.dart';

class NavigateButton<T> extends ConsumerWidget {
  const NavigateButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        right: MapViewBottomSheetConfig.horizontalPadding - 3,
      ),
      child: MyTextButton(
        onClick:
            ref.watch(context.activeMarkerController<T>().notifier).launchLink,
        actionTitle: context.localize.navigate,
      ),
    );
  }
}
