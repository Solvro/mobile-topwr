import "package:flutter/material.dart";
import "package:topwr/widgets/detail_views/contact_icon_widget.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ContactIconWidget)
Widget useCaseContactIconWidget(BuildContext context) {
  const iconOptions = <String>[
    "packages/topwr/assets/svg/contact_icons/web.svg",
    "packages/topwr/assets/svg/contact_icons/mail.svg",
    "packages/topwr/assets/svg/contact_icons/phone.svg",
    "packages/topwr/assets/svg/contact_icons/linkedin.svg",
  ];

  return ContactIconWidget(
    icon: context.knobs.object.dropdown(
      label: "Icon asset path",
      options: iconOptions,
      initialOption: iconOptions.first,
    ),
  );
}
