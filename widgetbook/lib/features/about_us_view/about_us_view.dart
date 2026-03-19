import "package:flutter/widgets.dart";
import "package:topwr/features/about_us_view/about_us_view.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AboutUsView)
Widget useCaseAboutUsView(BuildContext context) {
  return const AboutUsView();
}
