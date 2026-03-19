import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/simple_previews/preview_card_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: PreviewCardLoading)
Widget useCasePreviewCardLoading(BuildContext context) {
  return const PreviewCardLoading(width: 300, height: 100);
}

@widgetbook.UseCase(name: ".square", type: PreviewCardLoading)
Widget useCasePreviewCardLoadingSquare(BuildContext context) {
  return const PreviewCardLoading.square(size: 100);
}
