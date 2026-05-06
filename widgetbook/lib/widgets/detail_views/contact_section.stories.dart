import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:topwr/utils/determine_contact_icon.dart";
import "package:topwr/widgets/detail_views/contact_section.dart";
import "package:widgetbook/widgetbook.dart";

part "contact_section.stories.g.dart";

// Cannot use `Meta<ContactSection>()` because `ContactSection.list` parameter name
// collides with the inherited `StoryArgs.list` getter; widgetbook v4-beta.3
// generator emits two `get list` members in the same class, which fails to compile.
// Tracked workaround: a custom Knobs class skips constructor-mirroring entirely.
class ContactSectionStoryKnobs {
  final String? title;
  final double topPadding;
  final bool shouldBeAccessible;
  ContactSectionStoryKnobs({this.title, required this.topPadding, required this.shouldBeAccessible});
}

const meta = MetaWithArgs<ContactSection, ContactSectionStoryKnobs>();

final _mockContactList = <ContactIconsModel>[
  ContactIconsModel(
    text: "support@topwr.app",
    url: "mailto:support@topwr.app",
    icon: "assets/svg/contact_icons/mail.svg",
  ),
  ContactIconsModel(text: "+1 415 555 0134", url: "tel:+14155550134", icon: "assets/svg/contact_icons/phone.svg"),
  ContactIconsModel(text: "topwr.app", url: "https://topwr.app", icon: "assets/svg/contact_icons/web.svg"),
].lock;

final defaults = _Defaults(
  builder: (context, args) => ContactSection(
    list: _mockContactList,
    title: args.title,
    topPadding: args.topPadding,
    shouldBeAccessible: args.shouldBeAccessible,
  ),
);

final $default = ContactSectionStory();
