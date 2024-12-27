import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../theme/app_theme.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../data/models/digital_guide_response_extended.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/adapted_toilet.dart";
import "../data/repository/adapted_toilets_repository.dart";

class AdaptedToiletsExpansionTileContent extends ConsumerWidget {
  const AdaptedToiletsExpansionTileContent({
    required this.digitalGuideResponseExtended,
  });

  final DigitalGuideResponseExtended digitalGuideResponseExtended;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAdaptedToilets = ref
        .watch(GetAdaptedToiltesProvider(digitalGuideResponseExtended.levels));
    return asyncAdaptedToilets.when(
      data: (adaptedToiletsData) => _AdaptedToiletsExpansionTileContent(
        levels: digitalGuideResponseExtended.levels
            .where(
              (level) =>
                  adaptedToiletsData.containsKey(level.id) &&
                  adaptedToiletsData[level.id]!.isNotEmpty,
            )
            .toList(),
        adaptedToiletsData: adaptedToiletsData,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _AdaptedToiletsExpansionTileContent extends ConsumerWidget {
  const _AdaptedToiletsExpansionTileContent({
    required this.levels,
    required this.adaptedToiletsData,
  });

  final List<Level> levels;
  final Map<int, List<AdaptedToilet>> adaptedToiletsData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: DigitalGuideConfig.heightMedium,
        left: DigitalGuideConfig.heightMedium,
        right: DigitalGuideConfig.heightMedium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: levels.map((level) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                level.translations.plTranslation.name,
                style: context.textTheme.title,
              ),
              const SizedBox(
                height: DigitalGuideConfig.heightSmall,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => DigitalGuideNavLink(
                  onTap: () async {
                    await ref.navigateAdaptedToiletDetails(
                      adaptedToiletsData[level.id]![index],
                    );
                  },
                  text: () {
                    switch (adaptedToiletsData[level.id]![index]
                        .hasAdditionalPurpose) {
                      case 1:
                        return context.localize.adapted_toilet_description;
                      case 2:
                        return context.localize.adapted_toilet_description_men;
                      case 3:
                        return context
                            .localize.adapted_toilet_description_women;
                      default:
                        return context.localize.adapted_toilet_description;
                    }
                  }(),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: DigitalGuideConfig.heightMedium,
                ),
                itemCount: adaptedToiletsData[level.id]!.length,
                shrinkWrap: true,
              ),
              const SizedBox(
                height: DigitalGuideConfig.heightMedium,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
