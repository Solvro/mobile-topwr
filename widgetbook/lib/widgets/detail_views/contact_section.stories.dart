import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/utils/determine_contact_icon.dart";
import "package:topwr/widgets/detail_views/contact_section.dart";
import "package:widgetbook/widgetbook.dart";

part "contact_section.stories.g.dart";

class ContactSectionStoryKnobs {
  final String? title;
  final double topPadding;
  final bool shouldBeAccessible;
  final IList<Widget>? bottomSpace;
  ContactSectionStoryKnobs({this.title, required this.topPadding, required this.shouldBeAccessible, this.bottomSpace});
}

const meta = MetaWithArgs<ContactSection, ContactSectionStoryKnobs>();

final defaults = _Defaults(
  builder: (context, args) => ContactSection(
    list: <ContactIconsModel>[
      ContactIconsModel(
        text: "support@topwr.app",
        url: "mailto:support@topwr.app",
        icon: "packages/topwr/assets/svg/contact_icons/mail.svg",
      ),
      ContactIconsModel(
        text: "+1 415 555 0134",
        url: "tel:+14155550134",
        icon: "packages/topwr/assets/svg/contact_icons/phone.svg",
      ),
      ContactIconsModel(
        text: "topwr.app",
        url: "https://topwr.app",
        icon: "packages/topwr/assets/svg/contact_icons/web.svg",
      ),
    ].lock,
    title: args.title,
    topPadding: args.topPadding,
    shouldBeAccessible: args.shouldBeAccessible,
    bottomSpace: args.bottomSpace,
  ),
);

final $default = ContactSectionStory();
