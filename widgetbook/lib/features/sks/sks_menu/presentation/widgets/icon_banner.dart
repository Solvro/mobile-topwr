import "package:flutter/material.dart";
import "package:topwr/features/sks/sks_menu/presentation/widgets/icon_banner.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: IconBanner)
Widget useCaseIconBanner(BuildContext context) {
  return IconBanner(
    icon: context.knobs.object.dropdown(label: "Icon", options: [Icons.info, Icons.home, Icons.settings]),
    color: context.knobs.color(label: "Color"),
    iconColor: context.knobs.color(label: "Icon color"),
    size: context.knobs.double.input(label: "Size"),
    visible: context.knobs.boolean(label: "Visible"),
    child: const SizedBox(width: 100, height: 100),
  );
}
