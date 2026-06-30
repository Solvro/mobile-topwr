import "package:topwr/features/digital_guide_objects/presentation/digital_guide_object_view.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_object_view.stories.g.dart";

const meta = Meta(DigitalGuideObjectView.new);

final $default = DigitalGuideObjectViewStory(
  name: "Production view with hardcoded data",
  args: DigitalGuideObjectViewArgs.fixed(ourId: "1"),
);
