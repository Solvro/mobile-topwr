import "package:flutter/widgets.dart";
import "package:topwr/features/home_view/widgets/loading_widgets/big_scrollable_section_loading.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: BigScrollableSectionLoading)
Widget useCaseBigScrollableSectionLoading(BuildContext context) {
  return BigScrollableSectionLoading(crossAxisForcedSize: context.knobs.double.input(label: "Cross axis forced size"));
}
