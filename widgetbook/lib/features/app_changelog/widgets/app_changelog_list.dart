import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:topwr/features/app_changelog/widgets/app_changelog_list.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

final _mockChangelog = Changelog(
  name: "v1.0.0",
  changes: IList(const [
    ChangelogChange(changeType: TypeOfChange.feature, name: "Added new feature"),
    ChangelogChange(changeType: TypeOfChange.fix, name: "Fixed bug"),
  ]),
);

@widgetbook.UseCase(name: "default", type: AppChangelogList)
Widget useCaseAppChangelogList(BuildContext context) {
  return AppChangelogList(changelog: _mockChangelog);
}
