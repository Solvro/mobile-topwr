import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../widgets/my_error_widget.dart";
import "../../departments/departments_view/repository/departments_repository.dart";
import "../science_clubs_filters/repository/tags_repository.dart";
import "widgets/sci_clubs_scaffold.dart";

class SafeLoadInitialRepos extends ConsumerWidget {
  const SafeLoadInitialRepos({super.key, required this.builder});

  final Widget Function(BuildContext context, {required bool safeLoadedTags, required bool safeLoadedDepartments})
  builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch ((ref.read(tagsRepositoryProvider), ref.read(departmentsRepositoryProvider))) {
      (AsyncError(:final error, :final stackTrace), _) || (_, AsyncError(:final error, :final stackTrace)) =>
        SciClubsScaffold(showFab: false, child: MyErrorWidget(error, stackTrace: stackTrace)),
      _ => builder(context, safeLoadedTags: true, safeLoadedDepartments: true),
    };
  }
}
