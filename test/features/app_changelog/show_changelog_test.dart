import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_test/flutter_test.dart";
import "package:topwr/features/app_changelog/data/models/changelog.dart";
import "package:topwr/features/app_changelog/show_changelog.dart";

void main() {
  Changelog buildChangelog(String version) {
    return Changelog(name: version, changes: const IListConst([]));
  }

  test("returns true when changelog matches app version", () {
    final changelog = buildChangelog("1.2.28");

    final result = isChangelogForAppVersion(appVersion: "1.2.28", changelog: changelog);

    expect(result, isTrue);
  });

  test("returns false when changelog does not match app version", () {
    final changelog = buildChangelog("1.1.21");

    final result = isChangelogForAppVersion(appVersion: "1.2.28", changelog: changelog);

    expect(result, isFalse);
  });

  test("returns false when app version is empty", () {
    final changelog = buildChangelog("1.2.28");

    final result = isChangelogForAppVersion(appVersion: "", changelog: changelog);

    expect(result, isFalse);
  });

  test("returns false when app version is whitespace only", () {
    final changelog = buildChangelog("1.2.28");

    final result = isChangelogForAppVersion(appVersion: " ", changelog: changelog);

    expect(result, isFalse);
  });
}
