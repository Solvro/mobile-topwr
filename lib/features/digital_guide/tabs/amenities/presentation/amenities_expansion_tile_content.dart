import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../../../config/ui_config.dart";
import "../../../../../gen/assets.gen.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/determine_contact_icon.dart";
import "../../../../../widgets/detail_views/contact_section.dart";
import "../../../data/models/digital_guide_response.dart";

class AmenitiesExpansionTileContent extends StatelessWidget {
  const AmenitiesExpansionTileContent({super.key, required this.digitalGuideData});

  final DigitalGuideResponse digitalGuideData;

  @override
  Widget build(BuildContext context) {
    return ContactSection(
      topPadding: DigitalGuideConfig.heightTiny,
      shouldBeAccessible: true,
      list: [
        if (digitalGuideData.canAssistanceDog)
          ContactIconsModel(text: context.localize.assistance_dog, icon: Assets.svg.digitalGuide.assistanceDog),
        if (digitalGuideData.isInductionLoop)
          ContactIconsModel(text: context.localize.induction_loop, icon: Assets.svg.digitalGuide.inductionLoop),
        if (digitalGuideData.isMicroNavigationSystem)
          ContactIconsModel(
            text: context.localize.micronavigation_system,
            icon: Assets.svg.digitalGuide.micronavigation,
          ),
        if (digitalGuideData.areGuidancePaths)
          ContactIconsModel(text: context.localize.orientation_paths, icon: Assets.svg.digitalGuide.orientationPaths),
        if (digitalGuideData.areBrailleBoards)
          ContactIconsModel(
            text: context.localize.information_boards_with_braille_description,
            icon: Assets.svg.digitalGuide.braille,
          ),
        if (digitalGuideData.areLargeFontBoards)
          ContactIconsModel(
            text: context.localize.information_boards_with_large_font,
            icon: Assets.svg.digitalGuide.largeFont,
          ),
        if (digitalGuideData.isSignLanguageInterpreter)
          ContactIconsModel(
            text: context.localize.sign_language_interpreter,
            icon: Assets.svg.digitalGuide.signLanguage,
          ),
        if (digitalGuideData.areEmergencyChairs)
          ContactIconsModel(text: context.localize.emergency_chairs, icon: Assets.svg.digitalGuide.emergencyChairs),
      ].lock,
    );
  }
}
