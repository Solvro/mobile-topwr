import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/specific_imitations/big_preview_card_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BigPreviewCardLoading)
Widget useCaseBigPreviewCardLoading(BuildContext context) {
  return const BigPreviewCardLoading();
}
