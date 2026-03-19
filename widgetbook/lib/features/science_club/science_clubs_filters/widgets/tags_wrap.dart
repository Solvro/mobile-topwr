import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_filters/widgets/tags_wrap.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: TagsWrap)
Widget useCaseTagsWrap(BuildContext context) {
  return const TagsWrap();
}
