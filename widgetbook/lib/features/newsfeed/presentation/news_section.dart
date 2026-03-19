import "package:flutter/widgets.dart";
import "package:topwr/features/newsfeed/presentation/news_section.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: NewsSection)
Widget useCaseNewsSection(BuildContext context) {
  return const NewsSection();
}
