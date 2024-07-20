import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/department_details_loading.dart';
import '../../config/ui_config.dart';
import 'widgets/department_study_circle_section.dart';
import 'widgets/fields_of_study_section.dart';
import '../../api_base/directus_assets_url.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../utils/determine_icon.dart';
import '../../utils/where_non_null_iterable.dart';
import '../../widgets/my_error_widget.dart';
import '../study_circle_details/widgets/details_screen_app_bar.dart';
import '../study_circle_details/widgets/details_screen_contact_section.dart';
import '../study_circle_details/widgets/details_screen_sliver_header_section.dart';
import 'repositories/department_details_repository.dart';
import '../department_details/utils/address_formatter.dart';
import '../department_details/utils/department_details_gradient.dart';

class DepartmentDetails extends StatelessWidget {
  const DepartmentDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsScreenAppBar(context, title: context.localize.departments),
      body: const _DepartmentDetailsDataView(),
    );
  }
}
class _DepartmentDetailsDataView extends ConsumerWidget {
  const _DepartmentDetailsDataView({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemId = ModalRoute.of(context)?.settings.arguments as String;
    final state = ref.watch(departmentDetailsRepositoryProvider(itemId));
    return switch (state) {
      AsyncLoading() => const DepartmentDetailsLoading(),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => CustomScrollView(slivers: [
          SliverPersistentHeader(
              delegate: SliverHeaderSection(
                activeGradient: value?.Departments_by_id?.gradient,
            logoImageUrl:
                value?.Departments_by_id?.logo?.filename_disk?.directusUrl,
            backgroundImageUrl: null,
          )),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 8),
            Text(
              value?.Departments_by_id?.name ?? '',
              style: context.textTheme.headline,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            Text(
              value?.Departments_by_id?.address?.divideAddressInto3Lines ?? '',
              style: context.textTheme.body.copyWith(height: 1.2),
              textAlign: TextAlign.center,
            ),
                const SizedBox(height: DetailsScreenConfig.spacerHeight),
            ContactSection(
                title: context.localize.deans_office,
                list: value?.Departments_by_id?.links.whereNonNull
                        .map((link) => UrlIconsModel(
                              text: link.name,
                              url: link.link,
                            ))
                        .toList() ??
                    List.empty()),
            FieldsOfStudySection(
              fieldsOfStudy: value?.Departments_by_id?.fieldsOfStudies
                      ?.map((e) => e?.name ?? "")
                      .toList() ??
                  List.empty(),
            ),
            DepartmentsStudyCircleSection(
                value?.Scientific_Circles.whereNotNull().toList() ??
                    List.empty()),
          ]))
        ]),
    };
  }
}



