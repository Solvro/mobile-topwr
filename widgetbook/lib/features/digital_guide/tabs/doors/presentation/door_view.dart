import "package:flutter/widgets.dart";
import "package:topwr/features/digital_guide/tabs/doors/presentation/door_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: DoorView)
Widget useCaseDoorView(BuildContext context) {
  return const DoorView(doorsID: 1);
}
