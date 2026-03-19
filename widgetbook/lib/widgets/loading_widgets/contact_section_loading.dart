import "package:flutter/widgets.dart";
import "package:topwr/widgets/loading_widgets/contact_section_loading.dart";
import "package:topwr/widgets/loading_widgets/shimmer_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: ContactSectionLoading)
Widget useCaseContactSectionLoading(BuildContext context) {
  return const Shimmer(
    linearGradient: shimmerGradient,
    child: ContactSectionLoading(),
  );
}
