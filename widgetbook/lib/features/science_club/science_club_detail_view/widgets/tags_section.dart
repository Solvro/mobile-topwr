import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:topwr/features/science_club/science_club_detail_view/widgets/tags_section.dart";
import "package:topwr/features/science_club/science_clubs_filters/model/tags.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _productionTags = IList<Tag>(const [Tag(tag: "Informatyka"), Tag(tag: "Elektronika"), Tag(tag: "Sport")]);

@widgetbook.UseCase(name: "default", type: TagsSection)
Widget useCaseTagsSectionDefault(BuildContext context) {
  return TagsSection(tags: _productionTags);
}
