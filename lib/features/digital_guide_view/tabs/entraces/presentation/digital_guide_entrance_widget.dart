import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/business/entrances_use_cases.dart";
import "../data/models/digital_guide_entrace.dart";
import "../presentation/entraces_detail_view.dart";

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
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => DigitalGuideNavLink(
            onTap: () async {
              ref.read(selectedEntranceProvider.notifier).state = entrance;
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DigitalGuideEntranceDetails(
                    entrance: entrance,
                  ),
                ),
              );
            },
            text: entrance.translations.plTranslation.name,
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: DigitalGuideConfig.heightMedium,
          ),
          itemCount: 1,
          shrinkWrap: true,
        ),
        const SizedBox(
          height: DigitalGuideConfig.heightMedium,
        ),
      ],
    );
  }
}
