import "package:flutter/widgets.dart";
import "package:topwr/widgets/general_offline_message.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: OfflineMessage)
Widget useCaseOfflineMessage(BuildContext context) {
  return const OfflineMessage("Sample error message");
}
