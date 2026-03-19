import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/presentation/widgets/bullet_list.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockItems = IList<String>(const [
  "First item in the list",
  "Second item in the list",
  "Third item with more details",
]);

@widgetbook.UseCase(name: "default", type: BulletList)
Widget useCaseBulletList(BuildContext context) {
  return BulletList(items: _mockItems);
}
