import "package:flutter/widgets.dart";
import "package:topwr/widgets/my_expansion_tile.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: MyExpansionTile)
Widget useCaseMyExpansionTile(BuildContext context) {
  return MyExpansionTile(
    title: context.knobs.string(label: "Title", initialValue: "Title"),
    initiallyExpanded: context.knobs.boolean(label: "Initially expanded"),
    backgroundColor: context.knobs.colorOrNull(label: "Background color"),
    collapsedBackgroundColor: context.knobs.colorOrNull(label: "Collapsed background color"),
    children: context.knobs.object.dropdown(
      label: "Children",
      options: [
        [const Text("Child 1"), const Text("Child 2")],
        [const Text("Single Child")],
      ],
    ),
  );
}
