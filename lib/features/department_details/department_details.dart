import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../api_base/directus_assets_url.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../widgets/my_error_widget.dart';
import '../study_circle_details/widgets/details_screen_app_bar.dart';
import '../study_circle_details/widgets/details_screen_sliver_header_section.dart';
import 'repositories/department_details_repository.dart';

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
    //final itemId = ModalRoute.of(context)?.settings.arguments as String;
    const itemId = "1";
    final state = ref.watch(departmentDetailsRepositoryProvider(itemId));
    return switch (state) {
      //TODO: replace MyErrorWidget with the LoadingWidget
      AsyncLoading() => const MyErrorWidget(""),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => CustomScrollView(slivers: [
          SliverPersistentHeader(
              delegate: SliverHeaderSection(
            logoImageUrl:
                value?.Departments_by_id?.logo?.filename_disk?.directusUrl,
            backgroundImageUrl: null,
          )),
        SliverList(delegate: SliverChildListDelegate([
          const SizedBox(height: 8),
          Text(
            value?.Departments_by_id?.name ?? '',
            style: context.textTheme.headline,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          Text(
            value?.Departments_by_id?.address?.formattedAddress ?? '',
            style: context.textTheme.body.copyWith(height: 1.2),
            textAlign: TextAlign.center,
          ),
        ]))
        ]),
    };
  }
}

extension AddressFormatting on String {
  String get formattedAddress {
    final parts = split(' ');
    final postalCodeIndex = parts.indexWhere((part) => RegExp(r'^\d{2}-\d{3}$').hasMatch(part));
    final streetStartIndex = parts.indexWhere((part) => RegExp('^ul.').hasMatch(part));
    final postalCodeAndCity = parts.sublist(postalCodeIndex).join(' ');
    final streetAddress = parts.sublist(streetStartIndex, postalCodeIndex).join(' ');
    final name = parts.sublist(0,streetStartIndex).join(' ');
    return '$name\n$streetAddress\n$postalCodeAndCity';
  }
}

