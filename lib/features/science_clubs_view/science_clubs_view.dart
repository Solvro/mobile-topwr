import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../utils/context_extensions.dart";
import "../../widgets/search_box_app_bar.dart";
import "../departments_view/repository/departments_repository.dart";
import "../science_clubs_filters/filters_controller.dart";
import "../science_clubs_filters/hooks/use_initial_filter_ids.dart";
import "../science_clubs_filters/model/sci_club_type.dart";
import "../science_clubs_filters/repository/tags_repository.dart";
import "../science_clubs_filters/widgets/filters_fab.dart";
import "controllers/science_clubs_view_controller.dart";
import "widgets/science_clubs_list.dart";

@RoutePage()
class ScienceClubsView extends StatelessWidget {
  const ScienceClubsView({
    super.key,
    @QueryParam("tags") this.tagsIdsSequence,
    @QueryParam("depts") this.deptsIdsSequence,
    @QueryParam("types") this.typesSequence,
  });
  final String? tagsIdsSequence;
  final String? deptsIdsSequence;
  final String? typesSequence;

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
      ),
    );
  }
}

class _ScienceClubsView extends HookConsumerWidget {
  const _ScienceClubsView({
    required this.tagsIds,
    required this.deptsIds,
    required this.types,
  });
  final IList<String> tagsIds;
  final IList<String> deptsIds;
  final IList<String> types;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useInitialFilterIds(
      tagsIds.map((it) => it.toLowerCase()).toIList(),
      () async => ref.read(tagsRepositoryProvider.future),
      ref.watch(selectedTagControllerProvider.notifier),
      (ids, tag) => ids.contains(tag.name.toLowerCase()),
    );

    useInitialFilterIds(
      deptsIds,
      () async => ref.read(departmentsRepositoryProvider.future),
      ref.watch(selectedDepartmentControllerProvider.notifier),
      (ids, dept) => ids.contains(dept.id),
    );

    useInitialFilterIds(
      types.map((it) => it.toLowerCase()).toIList(),
      () async => ScienceClubType.values.toIList(),
      ref.watch(selectedTypeControllerProvider.notifier),
      (ids, type) => ids.contains(type.toJson()?.toLowerCase()),
    );

    return Scaffold(
      appBar: SearchBoxAppBar(
        context,
        title: context.localize.study_circles,
        onQueryChanged: ref
            .watch(searchScienceClubsControllerProvider.notifier)
            .onTextChanged,
      ),
      floatingActionButton: const FiltersFAB(),
      body: const ScienceClubsList(),
    );
  }
}
