import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../widgets/my_error_widget.dart";
import "../../../../digital_guide_view/data/models/digital_guide_response.dart";
import "../../../../navigator/utils/navigation_commands.dart";
import "../../../presentation/widgets/digital_guide_nav_link.dart";
import "../data/models/micronavigation_response.dart";
import "../data/repository/micronavigation_repository.dart";

class MicronavigationExpansionTileContent extends ConsumerWidget {
  const MicronavigationExpansionTileContent({
    super.key,
    required this.digitalGuideData,
  });

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMicronavigationData = ref.watch(
      getMicronavigationDataProvider(
        digitalGuideData.externalId,
      ),
    );

    return asyncMicronavigationData.when(
      data: (micronavigationDataList) => _MicronavigationExpansionTileContent(
        micronavigationResponses: micronavigationDataList,
      ),
      error: (error, stackTrace) => MyErrorWidget(error),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _MicronavigationExpansionTileContent extends ConsumerWidget {
  const _MicronavigationExpansionTileContent({
    required this.micronavigationResponses,
  });

  final IList<MicronavigationResponse> micronavigationResponses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = micronavigationResponses.map((response) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          DigitalGuideConfig.paddingMedium,
          DigitalGuideConfig.paddingMedium,
          DigitalGuideConfig.paddingMedium,
          0,
        ),
        child: DigitalGuideNavLink(
          //CHANGE THIS WHEN WE WILL MAKE TRANSLATIONS!
          onTap: () async {
            await ref.navigateMicronavigationDetails(
              response.nameOverride.pl ?? "",
              response.webContent.pl ?? "",
              response.languages
                      .where((a) => a.langCode == "pl")
                      .firstOrNull
                      ?.sound ??
                  "",
            );
          },
          text: response.nameOverride.pl ?? "",
        ),
      );
    }).toIList();

    return Padding(
      padding: const EdgeInsets.only(bottom: DigitalGuideConfig.paddingMedium),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widgets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => widgets[index],
      ),
    );
  }
}