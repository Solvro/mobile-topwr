import "package:topwr/features/digital_guide/presentation/digital_guide_view.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_view.stories.g.dart";

const meta = Meta<DigitalGuideView>();

final $default = DigitalGuideViewStory(
  name: "Production view with hardcoded data",
  args: DigitalGuideViewArgs.fixed(ourId: "1"),
);
