import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/specific_imitations/button_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ButtonLoading)
Widget useCaseButtonLoading(BuildContext context) {
  return const ButtonLoading();
}
