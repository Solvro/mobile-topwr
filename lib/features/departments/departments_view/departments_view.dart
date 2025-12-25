import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/search_box_app_bar.dart";
import "../../../widgets/search_not_found.dart";
import "../../analytics/data/clarity.dart";
import "../../analytics/data/clarity_events.dart";
import "../../navigator/utils/navigation_commands.dart";
import "data/models/department.dart";
import "departments_view_controllers.dart";
import "widgets/department_card.dart";
import "widgets/departments_view_loading.dart";

@RoutePage()
class DepartmentsView extends StatelessWidget {
  const DepartmentsView({super.key, @QueryParam("q") this.initialQuery});

  final String? initialQuery;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.departments);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [searchDepartmentsControllerProvider],
      child: _DepartmentsView(initialQuery: initialQuery),
    );
  }
}

class _DepartmentsView extends ConsumerWidget {
  const _DepartmentsView({this.initialQuery});

  final String? initialQuery;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (initialQuery != null && initialQuery!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(searchDepartmentsControllerProvider.notifier).onTextChanged(initialQuery!);
      });
    }

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: SearchBoxAppBar(
        primary: true,
        addLeadingPopButton: true,
        context,
        initialQuery: initialQuery,
        title: context.localize.departments,
        onQueryChanged: ref.watch(searchDepartmentsControllerProvider.notifier).onTextChanged,
        onSearchBoxTap: () {
          unawaited(ref.trackEvent(ClarityEvents.searchDepartments));
        },
      ),
      body: Semantics(label: context.localize.departments, child: const _DepartmentsViewListBody()),
    );
  }
}

class _DepartmentsViewListBody extends ConsumerWidget {
  const _DepartmentsViewListBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentsListProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: switch (state) {
        AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
        AsyncValue(:final IList<Department> value) => _DepartmentsDataView(value),
        _ => const DepartmentsViewLoading(),
      },
    );
  }
}

class _DepartmentsDataView extends ConsumerWidget {
  const _DepartmentsDataView(this.departments);

  final IList<Department> departments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (departments.isEmpty) {
      return Semantics(
        label: context.localize.department_not_found,
        child: SearchNotFound(message: context.localize.department_not_found),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      gridDelegate: DepartmentsConfig.departmentsViewGridDelegate(context),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final department = departments[index];
        return Semantics(
          label: department.name,
          button: true,
          child: DepartmentCard(department, onClick: () => ref.navigateDepartmentDetail(department.id)),
        );
      },
    );
  }
}
