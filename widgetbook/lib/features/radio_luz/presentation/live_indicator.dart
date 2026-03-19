import "package:flutter/widgets.dart";
import "package:topwr/features/radio_luz/presentation/live_indicator.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: LiveIndicator)
Widget useCaseLiveIndicator(BuildContext context) {
  return LiveIndicator(
    radius: context.knobs.double.input(label: "Radius"),
    spreadRadius: context.knobs.double.input(label: "Spread radius"),
    color: context.knobs.color(label: "Color"),
    spreadDuration: context.knobs.duration(label: "Spread duration"),
    waitDuration: context.knobs.duration(label: "Wait duration"),
  );
}
