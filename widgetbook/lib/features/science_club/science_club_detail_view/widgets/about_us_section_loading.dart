import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_club_detail_view/widgets/about_us_section_loading.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AboutUsSectionLoading)
Widget useCaseAboutUsSectionLoading(BuildContext context) {
  return const AboutUsSectionLoading();
}
