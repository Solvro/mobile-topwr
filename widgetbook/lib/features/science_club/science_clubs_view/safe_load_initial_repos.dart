import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:topwr/features/science_club/science_clubs_view/safe_load_initial_repos.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: SafeLoadInitialRepos)
Widget useCaseSafeLoadInitialRepos(BuildContext context) {
  return SafeLoadInitialRepos(
    builder: (context, {required bool safeLoadedTags, required bool safeLoadedDepartments}) {
      return const Center(child: Text("Safe Loaded!"));
    },
  );
}
