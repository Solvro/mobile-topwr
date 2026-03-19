import "package:flutter/widgets.dart";
import "package:topwr/features/update_dialog/presentation/update_dialog_wrapper.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: UpdateDialogWrapper)
Widget useCaseUpdateDialogWrapper(BuildContext context) {
  return const UpdateDialogWrapper(child: SizedBox(width: 100, height: 100));
}
