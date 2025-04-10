import "package:auto_route/auto_route.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../services/translations_service/widgets/text_with_translation.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/determine_contact_icon.dart";
import "../../../widgets/detail_views/contact_section.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../widgets/my_error_widget.dart";
import "data/models/detailed_department.dart";
import "data/repository/department_details_extension.dart";
import "data/repository/department_details_repository.dart";
import "widgets/fields_of_study_section.dart";
import "widgets/science_clubs_section.dart";
import "widgets/sliver_header_section.dart";
import "widgets/view_loading.dart";

@RoutePage()
class DepartmentDetailView extends ConsumerWidget {
  const DepartmentDetailView({@PathParam("id") required this.id, super.key});
  final int id;

  static String localizedOfflineMessage(BuildContext context) {
    return context.localize.my_offline_error_message(context.localize.department);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(departmentDetailsRepository2Provider(id));
    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(),
      body: switch (state) {
        AsyncError(:final error) => MyErrorWidget(error),
        AsyncValue(value: final DetailedDepartment department) => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: DepartmentSliverHeaderSection(
                activeGradient: department.gradient,
                logoDirectusImageUrl: department.imageUrl,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextWithTranslation(
                    department.name,
                    style: context.textTheme.headline,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(height: 12),
                TextWithTranslation(
                  department.get3LinesAddress(),
                  style: context.textTheme.body.copyWith(height: 1.2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DetailViewsConfig.spacerHeight),
                ContactSection(
                  title: context.localize.deans_office,
                  list:
                      department.departmentLink
                          .map((link) => ContactIconsModel(text: link.name, url: link.url))
                          .toIList(),
                ),
                FieldsOfStudySection(fieldsOfStudy: department.fieldOfStudy),
                DepartmentScienceClubsSection(department),
                const SizedBox(height: DetailViewsConfig.spacerHeight * 2),
              ]),
            ),
          ],
        ),
        _ => const DepartmentDetailViewLoading(),
      },
    );
  }
}
