import "package:flutter/widgets.dart";
import "package:topwr/widgets/technical_message.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: TechnicalMessage)
Widget useCaseTechnicalMessage(BuildContext context) {
  return TechnicalMessage(
    message: context.knobs.string(label: "Message", initialValue: "Message"),
    title: context.knobs.stringOrNull(label: "Title"),
    titleColor: context.knobs.colorOrNull(label: "Title color"),
    alertType: context.knobs.object.dropdown(label: "Alert type", options: AlertType.values),
    icon: context.knobs.objectOrNull.dropdown(label: "Icon", options: <Icon>[]),
    onTap: () {},
    backgoundColor: context.knobs.colorOrNull(label: "Backgound color"),
    textColor: context.knobs.colorOrNull(label: "Text color"),
    translate: context.knobs.boolean(label: "Translate"),
    padding: context.knobs.objectOrNull.dropdown(
      label: "Padding",
      options: <EdgeInsets>[
        EdgeInsets.zero,
        const EdgeInsets.all(16),
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ],
    ),
  );
}
