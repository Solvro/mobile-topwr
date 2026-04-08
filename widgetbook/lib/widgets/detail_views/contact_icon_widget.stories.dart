import "package:topwr/widgets/detail_views/contact_icon_widget.dart";
import "package:widgetbook/widgetbook.dart";

part "contact_icon_widget.stories.g.dart";

class ContactIconWidgetStoryKnobs {
  final String icon;
  ContactIconWidgetStoryKnobs({required this.icon});
}

const meta = MetaWithArgs<ContactIconWidget, ContactIconWidgetStoryKnobs>();

/// Bundled by the topwr package; same path pattern as other widgetbook SVG mocks.
const _defaultContactSvg = "packages/topwr/assets/svg/contact_icons/mail.svg";

final defaults = _Defaults(builder: (context, args) => ContactIconWidget(icon: args.icon));

final $default = ContactIconWidgetStory(args: ContactIconWidgetStoryKnobsArgs(icon: Arg.fixed(_defaultContactSvg)));
