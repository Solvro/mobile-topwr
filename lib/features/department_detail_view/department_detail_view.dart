import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../api_base/directus_assets_url.dart";
import "../../config/ui_config.dart";
import "../../theme/app_theme.dart";
import "../../utils/context_extensions.dart";
import "../../utils/determine_contact_icon.dart";
import "../../utils/where_non_null_iterable.dart";
import "../../widgets/detail_views/contact_section.dart";
import "../../widgets/detail_views/detail_view_app_bar.dart";
import "../../widgets/detail_views/sliver_header_section.dart";
import "../../widgets/my_error_widget.dart";
import "repository/department_details_repository.dart";
import "utils/address_formatter.dart";
import "utils/department_details_gradient.dart";
import "widgets/department_detail_view_loading.dart";
import "widgets/department_science_clubs_section.dart";
import "widgets/fields_of_study_section.dart";

@RoutePage()
class DepartmentDetailView extends ConsumerWidget {
  const DepartmentDetailView({@PathParam("id") required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentDetailsRepositoryProvider(id));
    return Scaffold(
      appBar: DetailViewAppBar(context, title: context.localize.departments),
      body: switch (state) {
        AsyncLoading() => const DepartmentDetailViewLoading(),
        AsyncError(:final error) => MyErrorWidget(error),
        AsyncValue(:final value) => CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: SliverHeaderSection(
                  activeGradient: value?.Departments_by_id?.gradient,
                  logoImageUrl: value
                      ?.Departments_by_id?.logo?.filename_disk?.directusUrl,
                  backgroundImageUrl: null,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  Text(
                    value?.Departments_by_id?.name ?? "",
                    style: context.textTheme.headline,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    value?.Departments_by_id?.address
                            ?.divideAddressInto3Lines ??
                        "",
                    style: context.textTheme.body.copyWith(height: 1.2),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DetailViewsConfig.spacerHeight),
                  ContactSection(
                    title: context.localize.deans_office,
                    list: value?.Departments_by_id?.links.whereNonNull
                            .map(
                              (link) => ContactIconsModel(
                                text: link.name,
                                url: link.link,
                              ),
                            )
                            .toList() ??
                        List.empty(),
                  ),
                  FieldsOfStudySection(
                    fieldsOfStudy: value
                            ?.Departments_by_id?.fieldsOfStudies.whereNonNull
                            .map((e) => e.name)
                            .toList() ??
                        List.empty(),
                  ),
                  DepartmentScienceClubsSection(
                    value?.Scientific_Circles.whereNonNull.toList() ??
                        List.empty(),
                  ),
                ]),
              ),
            ],
          ),
      },
    );
  }
}
