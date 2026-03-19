import "package:flutter/widgets.dart";
import "package:topwr/features/update_dialog/presentation/ios_update.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: IosUpdateWidget)
Widget useCaseIosUpdateWidget(BuildContext context) {
  return const IosUpdateWidget(child: SizedBox(width: 100, height: 100));
}
