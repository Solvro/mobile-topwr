import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../hooks/use_filters_sheet_height.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/text_and_url_widget.dart";
import "../../../bottom_scroll_sheet/drag_handle.dart";
import "../../sks_people_live/data/repository/latest_sks_user_data_repo.dart";
import "../data/models/sks_chart_data.dart";
import "../data/repository/sks_chart_repository.dart";
import "sks_chart_card.dart";

// TODO(mikolaj-jalocha): create shimmer loading

class SksChartSheet extends ConsumerWidget {
  const SksChartSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(sksChartRepositoryProvider);
    final asyncNumberOfUsers = ref.watch(getLatestSksUserDataProvider);

    final currentNumberOfUsers = asyncNumberOfUsers.value;
    final maxNumberOfUsers = asyncChartData.value?.maxNumberOfUsers ?? 0;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final sheetHeight = useFiltersSheetHeight(
      context,
      prefferedHeightFactor: screenWidth > 400 ? .62 : .68,
    );

    return switch (asyncChartData) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncLoading() => const SizedBox.shrink(),
      AsyncValue() => HorizontalSymmetricSafeArea(
          child: SizedBox(
            height: sheetHeight,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: SksChartConfig.paddingLargeLTR
                      .copyWith(bottom: SksChartConfig.paddingMedium),
                  child: const _SksSheetHeader(),
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SksChartConfig.paddingMedium,
                        ),
                        child: SksChartCard(
                          currentNumberOfUsers: currentNumberOfUsers,
                          maxNumberOfUsers: maxNumberOfUsers,
                          chartData:
                              asyncChartData.value ?? const IList.empty(),
                          height: sheetHeight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(
                          SksChartConfig.paddingSmall,
                        ),
                        child: TextAndUrl(
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
        Padding(
          padding: const EdgeInsets.all(8).copyWith(bottom: 0),
          child: Text(
            context.localize.sks_chart_title,
            style: context.textTheme.headline,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
