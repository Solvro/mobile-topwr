import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/guide_view/widgets/guide_grid.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: GuideGrid)
Widget useCaseGuideGrid(BuildContext context) {
  return GuideGrid(
    children: IList([
      Container(width: 100, height: 100, color: Colors.red),
      Container(width: 100, height: 100, color: Colors.green),
      Container(width: 100, height: 100, color: Colors.blue),
    ]),
  );
}
