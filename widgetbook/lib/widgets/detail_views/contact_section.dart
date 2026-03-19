import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/utils/determine_contact_icon.dart";
import "package:topwr/widgets/detail_views/contact_section.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ContactSection)
Widget useCaseContactSection(BuildContext context) {
  final bottomSpaceOptions = <IList<Widget>>[
    const <Widget>[SizedBox(height: 8)].lock,
    const <Widget>[SizedBox(height: 24)].lock,
  ];

  return ContactSection(
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
    title: context.knobs.stringOrNull(label: "Title"),
    topPadding: context.knobs.double.input(label: "Top padding"),
    shouldBeAccessible: context.knobs.boolean(label: "Should be accessible"),
    bottomSpace: context.knobs.objectOrNull.dropdown(
      label: "Bottom space",
      options: bottomSpaceOptions,
      initialOption: bottomSpaceOptions.first,
    ),
  );
}
