import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/header_section_loading.dart";
import "package:topwr/widgets/loading_widgets/shimmer_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: HeaderSectionLoading)
Widget useCaseHeaderSectionLoading(BuildContext context) {
  return const Shimmer(
    linearGradient: shimmerGradient,
    child: HeaderSectionLoading(),
  );
}
