import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_error_widget.dart";
import "../../bottom_scroll_sheet/drag_handle.dart";
import "../../sks_menu/presentation/widgets/sks_menu_data_source_link.dart";
import "../../sks_people_live/data/repository/latest_sks_user_data_repo.dart";
import "../data/models/sks_chart_data.dart";
import "../data/repository/sks_chart_repository.dart";
import "sks_chart_card.dart";

// TODO(mikolaj-jalocha): create shimmer loading

class SksChartSheet extends ConsumerWidget {
  const SksChartSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(getLatestChartDataProvider);
    final asyncNumberOfUsers = ref.watch(getLatestSksUserDataProvider);

    final currentNumberOfUsers = asyncNumberOfUsers.value;
    final maxNumberOfUsers = asyncChartData.value?.maxNumberOfUsers ?? 0;

    return switch (asyncChartData) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncLoading() => const SizedBox.shrink(),
      AsyncValue() => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SksChartConfig.paddingExtraSmall,
          ),
          child: Column(
            children: [
              Padding(
                padding: SksChartConfig.paddingLargeLTR
                    .copyWith(bottom: SksChartConfig.paddingMedium),
                child: const _SksSheetHeader(),
              ),
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        SksChartConfig.paddingMedium,
                        SksChartConfig.paddingMedium,
                        SksChartConfig.paddingMedium,
                        0,
                      ),
                      child: SksChartCard(
                        currentNumberOfUsers: currentNumberOfUsers,
                        maxNumberOfUsers: maxNumberOfUsers,
                        chartData: asyncChartData.value ?? const IList.empty(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        SksChartConfig.paddingSmall,
                      ),
                      child: SksMenuDataSourceLink(
                        SksChartConfig.sksChartDataUrl,
                        "${context.localize.data_come_from_website}: ",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    };
  }
}

class _SksSheetHeader extends StatelessWidget {
  const _SksSheetHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LineHandle(),
        const SizedBox(height: SksChartConfig.heightSmall),
        Text(
          context.localize.sks_chart_title,
          style: context.textTheme.headline
              .copyWith(color: context.colorTheme.blueAzure),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
