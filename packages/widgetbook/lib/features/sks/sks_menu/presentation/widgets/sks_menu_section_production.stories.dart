import "package:flutter/widgets.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/sks_menu_section.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../../../widgetbook_mocks.dart";

part "sks_menu_section_production.stories.g.dart";

class SksMenuSectionProductionStory extends StatelessWidget {
  const SksMenuSectionProductionStory({super.key});

  @override
  Widget build(BuildContext context) {
    return SksMenuSection(mockSksMenuDishes);
  }
}

const meta = Meta(SksMenuSectionProductionStory.new);

final $fromProduction = SksMenuSectionProductionStoryStory(name: "Hardcoded production snapshot");
