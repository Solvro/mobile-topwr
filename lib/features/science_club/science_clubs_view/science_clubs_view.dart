import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../utils/context_extensions.dart";
import "../../departments/departments_view/data/repository/departments_repository.dart";
import "../science_clubs_filters/filters_controller.dart";
import "../science_clubs_filters/hooks/use_initial_filter_ids.dart";
import "../science_clubs_filters/model/sci_club_type.dart";
import "../science_clubs_filters/repository/tags_repository.dart";
import "controllers/science_clubs_view_controller.dart";
import "safe_load_initial_repos.dart";
import "widgets/sci_clubs_scaffold.dart";
import "widgets/science_clubs_info_dialog.dart";
import "widgets/science_clubs_list.dart";

@RoutePage()
class ScienceClubsView extends StatelessWidget {
  const ScienceClubsView({
    super.key,
    @QueryParam("tags") this.tagsIdsSequence,
    @QueryParam("depts") this.deptsIdsSequence,
    @QueryParam("types") this.typesSequence,
    @QueryParam("q") this.initialQuery,
  });
  final String? tagsIdsSequence;
  final String? deptsIdsSequence;
  final String? typesSequence;
  final String? initialQuery;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.scientific_cirlces);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        searchScienceClubsControllerProvider,
        selectedDepartmentControllerProvider,
        selectedTagControllerProvider,
        selectedTypeControllerProvider,
      ],
      child: _ScienceClubsView(
        tagsIds: tagsIdsSequence?.split(",").toIList() ?? const IList.empty(),
        deptsIds: deptsIdsSequence?.split(",").toIList() ?? const IList.empty(),
        types: typesSequence?.split(",").toIList() ?? const IList.empty(),
        initialQuery: initialQuery,
      ),
    );
  }
}

class _ScienceClubsView extends StatelessWidget {
  const _ScienceClubsView({required this.tagsIds, required this.deptsIds, required this.types, this.initialQuery});
  final IList<String> tagsIds;
  final IList<String> deptsIds;
  final IList<String> types;
  final String? initialQuery;

  @override
  Widget build(BuildContext context) {
    return SafeLoadInitialRepos(
      builder: (context, {required safeLoadedDepartments, required safeLoadedTags}) => HookConsumer(
        builder: (context, ref, child) {
          useInitialFilterIds(
            tagsIds.map((it) => it.toLowerCase()).toIList(),
            () => ref.read(tagsRepositoryProvider.future),
            ref.watch(selectedTagControllerProvider.notifier),
            (ids, tag) => ids.contains(tag.tag.toLowerCase()),
          );

          useInitialFilterIds(
            deptsIds,
            () => ref.read(departmentsRepositoryProvider.future),
            ref.watch(selectedDepartmentControllerProvider.notifier),
            (ids, dept) => ids.contains(dept.id.toString()),
          );

          useInitialFilterIds(
            types.map((it) => it.toLowerCase()).toIList(),
            () async => ScienceClubType.values.toIList(),
            ref.watch(selectedTypeControllerProvider.notifier),
            (ids, type) => ids.contains(type.toJson()?.toLowerCase()),
          );

          return SciClubsScaffold(
            showFab: safeLoadedDepartments && safeLoadedTags,
            appBarActions: [
              IconButton(
                icon: Icon(Icons.info_outline, semanticLabel: context.localize.studyClub_howToAddYourOrganization),
                tooltip: context.localize.studyClub_howToAddYourOrganization,
                onPressed: () =>
                    showDialog<void>(context: context, builder: (context) => const ScienceClubInfoDialog()),
              ),
            ],
            initialQuery: initialQuery,
            child: child,
          );
        },
        child: const ScienceClubsList(),
      ),
    );
  }
}
