import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../data/models/level.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/digital_guide_lift.dart";

class DigitalGuideLiftLevel extends ConsumerWidget {
  const DigitalGuideLiftLevel({super.key, required this.level, required this.lifts});

  final Level level;
  final IList<DigitalGuideLift> lifts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(level.translations.plTranslation.name, style: context.textTheme.lightTitle),
        const SizedBox(height: 10),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder:
              (context, index) => DigitalGuideNavLink(
                onTap: () async {
                  await ref.navigateLiftDetails(lifts[index], level.translations.plTranslation.name);
                },
                text: context.localize.additional_information,
              ),
          separatorBuilder:
              (context, index) => SizedBox(
                height: index == lifts.length - 1 ? DigitalGuideConfig.heightSmall : DigitalGuideConfig.heightMedium,
              ),
          itemCount: lifts.length,
          shrinkWrap: true,
        ),
        const SizedBox(height: DigitalGuideConfig.heightMedium),
      ],
    );
  }
}
