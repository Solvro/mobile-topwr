import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../config/ui_config.dart";
import "../../../gen/assets.gen.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../widgets/detail_views/contact_section.dart";
import "../data/models/digital_guide_object_model.dart";

class DigitalGuideObjectAmenietesTabTileContent extends StatelessWidget {
  const DigitalGuideObjectAmenietesTabTileContent({required this.digitalGuideData});

  final DigitalGuideObjectModel digitalGuideData;

  @override
  Widget build(BuildContext context) {
    return ContactSection(
      topPadding: DigitalGuideConfig.heightTiny,
      list:
          [
            if (digitalGuideData.areGuidancePaths)
              ContactIconsModel(
                text: context.localize.orientation_paths,
                icon: Assets.svg.digitalGuide.orientationPaths,
              ),
            if (digitalGuideData.isMicronavigationSystem)
              ContactIconsModel(
                text: context.localize.micronavigation_system,
                icon: Assets.svg.digitalGuide.micronavigation,
              ),
            if (digitalGuideData.isPossibilityToEnterWithAssistanceDog)
              ContactIconsModel(text: context.localize.assistance_dog, icon: Assets.svg.digitalGuide.assistanceDog),
          ].lock,
    );
  }
}
