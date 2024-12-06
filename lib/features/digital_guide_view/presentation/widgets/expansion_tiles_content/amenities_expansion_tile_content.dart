import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../../../gen/assets.gen.dart";
import "../../../../../utils/context_extensions.dart";
import "../../../../../utils/determine_contact_icon.dart";
import "../../../../../widgets/detail_views/contact_section.dart";
import "../../../data/models/digital_guide_response.dart";

class AmenitiesExpansionTileContent extends StatelessWidget {
  const AmenitiesExpansionTileContent({
    required this.digitalGuideResponse,
  });

  final DigitalGuideResponse digitalGuideResponse;

  @override
  Widget build(BuildContext context) {
    return ContactSection(
      list: getIconsModels(context, digitalGuideResponse),
    );
  }
}

IList<ContactIconsModel> getIconsModels(
    BuildContext context, DigitalGuideResponse digitalGuideResponse) {
  IList<ContactIconsModel> iconsModels = IList<ContactIconsModel>();

  if (digitalGuideResponse.canAssistanceDog) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.assistance_dog,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  if (digitalGuideResponse.isInductionLoop) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.induction_loop,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  if (digitalGuideResponse.isMicroNavigationSystem) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.micronavigation_system,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  if (digitalGuideResponse.areGuidancePaths) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.guidance_paths,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  if (digitalGuideResponse.areBrailleBoards) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.information_boards_with_braille_description,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  if (digitalGuideResponse.areLargeFontBoards) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.information_boards_with_large_font,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  if (digitalGuideResponse.isSignLanguageInterpreter) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.sign_language_interpreter,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  if (digitalGuideResponse.areEmergencyChairs) {
    iconsModels = iconsModels.add(
      ContactIconsModel(
        text: context.localize.emergency_chairs,
        icon: Assets.svg.contactIcons.compass,
      ),
    );
  }

  return iconsModels;
}
