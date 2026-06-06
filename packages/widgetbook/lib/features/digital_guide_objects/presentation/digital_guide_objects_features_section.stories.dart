import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide_objects/data/models/digital_guide_object_model.dart";
import "package:topwr/features/digital_guide_objects/presentation/digital_g_objects_featers_list.dart";
import "package:widgetbook/widgetbook.dart";

import "../../../widgetbook_mocks.dart";

part "digital_guide_objects_features_section.stories.g.dart";

const meta = Meta<DigitalGuideObjectsFeaturesSliverList>();

final $default = DigitalGuideObjectsFeaturesSectionStory(
  setup: (context, child, args) => CustomScrollView(slivers: [child]),
  args: DigitalGuideObjectsFeaturesSectionArgs(digitalGuideData: Arg.fixed(mockDigitalGuideObjectModel)),
);
