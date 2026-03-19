import "package:flutter/widgets.dart";
import "package:topwr/features/update_dialog/presentation/android_update.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AndroidUpdateWidget)
Widget useCaseAndroidUpdateWidget(BuildContext context) {
  return const AndroidUpdateWidget(child: SizedBox(width: 100, height: 100));
}
