import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_nav_link.dart";
import "package:widgetbook/widgetbook.dart";

part "digital_guide_nav_link.stories.g.dart";

const meta = Meta(DigitalGuideNavLink.new);

final $default = DigitalGuideNavLinkStory(
  args: DigitalGuideNavLinkArgs.fixed(onTap: () {}, text: "Open digital guide details"),
);
