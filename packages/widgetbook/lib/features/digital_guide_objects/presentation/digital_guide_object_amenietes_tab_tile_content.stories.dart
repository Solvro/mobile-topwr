import "package:topwr/features/digital_guide_objects/data/models/digital_guide_object_model.dart";
import "package:topwr/features/digital_guide_objects/presentation/digital_g_objects_amenietes_tab_tile_content.dart";
import "package:widgetbook/widgetbook.dart";
import "../../../widgetbook_mocks.dart";

part "digital_guide_object_amenietes_tab_tile_content.stories.g.dart";

const meta = Meta<DigitalGuideObjectAmenietesTabTileContent>();

final $default = DigitalGuideObjectAmenietesTabTileContentStory(
  args: DigitalGuideObjectAmenietesTabTileContentArgs(digitalGuideData: Arg.fixed(mockDigitalGuideObjectModel)),
);
