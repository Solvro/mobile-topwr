import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/detail_views/detail_view_app_bar.dart";
import "../../../widgets/detail_views/logo_only_sliver_header_section.dart";
import "../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../widgets/loading_widgets/description_section_loading.dart";
import "../../../widgets/loading_widgets/header_section_loading.dart";
import "../../../widgets/loading_widgets/shimmer_loading.dart";
import "../../../widgets/my_error_widget.dart";
import "../../../widgets/wide_tile_card.dart";
import "../../navigator/utils/navigation_commands.dart";
import "../data/models/activity_days_stands_response.dart";
import "../data/repository/activity_days_stands_repository.dart";

@RoutePage()
class ActivityDaysStandDetailView extends ConsumerWidget {
  const ActivityDaysStandDetailView({@PathParam("id") required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stand = ref.watch(dasStandRepositoryProvider(id));

    return HorizontalSymmetricSafeAreaScaffold(
      appBar: DetailViewAppBar(),
      body: switch (stand) {
        AsyncError(:final error, :final stackTrace) => MyErrorWidget(error, stackTrace: stackTrace),
        AsyncData(:final value) => _StandDetails(stand: value),
        _ => const _StandDetailsLoading(),
      },
    );
  }
}

class _StandDetails extends ConsumerWidget {
  const _StandDetails({required this.stand});

  final DasStand stand;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organization = stand.dasOrganization;
    final studentOrganization = organization?.studentOrganization;

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(delegate: LogoOnlySliverHeaderSection(logoImageData: stand.logo)),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: HomeViewConfig.paddingSmall),
            Semantics(
              header: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
                child: Focus(
                  autofocus: true,
                  child: Text(
                    stand.effectiveName,
                    style: context.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: HomeViewConfig.paddingMedium),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: HomeViewConfig.paddingSmall,
                runSpacing: HomeViewConfig.paddingSmall,
                children: [
                  _MetadataPill(
                    icon: Icons.storefront_outlined,
                    label: context.localize.activity_days_stand_number(stand.number),
                  ),
                  if (stand.floor != null) _MetadataPill(icon: Icons.layers_outlined, label: stand.floor!.name),
                ],
              ),
            ),
            if (stand.effectiveDescription case final description? when description.trim().isNotEmpty) ...[
              const SizedBox(height: DetailViewsConfig.spacerHeight),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceTint,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(HomeViewConfig.paddingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.localize.activity_days_stand_description, style: context.textTheme.titleLarge),
                        const SizedBox(height: HomeViewConfig.paddingSmall),
                        Text(description, style: context.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            if (organization != null) ...[
              const SizedBox(height: DetailViewsConfig.spacerHeight),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
                child: Text(context.localize.activity_days_stand_organization, style: context.textTheme.titleLarge),
              ),
              const SizedBox(height: HomeViewConfig.paddingMedium),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
                child: WideTileCard(
                  title: organization.name,
                  subtitle: organization.description,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  fixedTrailingHeight: false,
                  contentPadding: const EdgeInsets.all(HomeViewConfig.paddingMedium),
                  onTap: studentOrganization == null
                      ? null
                      : () => ref.navigateSciClubDetailById(studentOrganization.id),
                  trailing: studentOrganization == null
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(right: HomeViewConfig.paddingMedium),
                          child: Icon(
                            Icons.chevron_right,
                            color: context.colorScheme.primary,
                            semanticLabel: context.localize.go_to,
                          ),
                        ),
                ),
              ),
            ],
            const SizedBox(height: HomeViewConfig.paddingLarge),
          ]),
        ),
      ],
    );
  }
}

class _MetadataPill extends StatelessWidget {
  const _MetadataPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      container: true,
      child: ExcludeSemantics(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: context.colorScheme.onPrimaryContainer, semanticLabel: label),
                const SizedBox(width: HomeViewConfig.paddingSmall),
                Text(
                  label,
                  style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StandDetailsLoading extends StatelessWidget {
  const _StandDetailsLoading();

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: shimmerGradient,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HeaderSectionLoading(),
          SizedBox(height: DetailViewsConfig.spacerHeight),
          DescriptionSectionLoading(),
        ],
      ),
    );
  }
}
