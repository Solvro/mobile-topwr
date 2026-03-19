import "package:flutter/widgets.dart";
import "package:topwr/widgets/horizontal_symmetric_safe_area.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: HorizontalSymmetricSafeAreaScaffold)
Widget useCaseHorizontalSymmetricSafeAreaScaffold(BuildContext context) {
  return HorizontalSymmetricSafeAreaScaffold(
    body: const SizedBox(width: 100, height: 100),
    bottomNavigationBar: const SizedBox(width: 100, height: 100),
    appBar: context.knobs.objectOrNull.dropdown(label: "App bar", options: <PreferredSizeWidget>[]),
    backgroundColor: context.knobs.colorOrNull(label: "Background color"),
    extraFabs: context.knobs.objectOrNull.dropdown(label: "Extra fabs", options: <List<Widget>>[]),
    top: context.knobs.boolean(label: "Top"),
  );
}
