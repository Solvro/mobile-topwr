import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/digital_guide_nav_link.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DigitalGuideNavLink)
Widget useCaseDigitalGuideNavLink(BuildContext context) {
  return DigitalGuideNavLink(onTap: () {}, text: "Sample text");
}
