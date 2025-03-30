import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../services/translations_service/widgets/text_with_translation.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../data/models/level.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/adapted_toilet.dart";

class AdaptedToiletLevel extends ConsumerWidget {
  const AdaptedToiletLevel({required this.level, required this.adaptedToilets});

  final Level level;
  final IList<AdaptedToilet> adaptedToilets;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithTranslation(level.translations.plTranslation.name, style: context.textTheme.lightTitle),
        const SizedBox(height: 10),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder:
              (context, index) => DigitalGuideNavLink(
                onTap: () async => ref.navigateAdaptedToiletDetails(adaptedToilets[index]),
                text: adaptedToilets[index].getDescription(context),
              ),
          separatorBuilder: (context, index) => const SizedBox(height: DigitalGuideConfig.heightMedium),
          itemCount: adaptedToilets.length,
          shrinkWrap: true,
        ),
        const SizedBox(height: DigitalGuideConfig.heightMedium),
      ],
    );
  }
}
