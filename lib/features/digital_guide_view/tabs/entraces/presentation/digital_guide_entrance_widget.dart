import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../digital_guide/presentation/widgets/digital_guide_nav_link.dart";
import "../../../../digital_guide/tabs/entraces/data/models/digital_guide_entrace.dart";
import "../../../../navigator/utils/navigation_commands.dart";

class DigitalGuideEntranceWidget extends ConsumerWidget {
  const DigitalGuideEntranceWidget({
    required this.entrance,
    super.key,
  });

  final DigitalGuideEntrace entrance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DigitalGuideNavLink(
          onTap: () async {
            await ref.navigateEntrancesDetails(entrance);
          },
          text: entrance.translations.pl.name ?? "",
        ),
        const SizedBox(height: DigitalGuideConfig.heightMedium),
      ],
    );
  }
}
