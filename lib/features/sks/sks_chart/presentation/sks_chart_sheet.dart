import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../hooks/use_filters_sheet_height.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../widgets/horizontal_symmetric_safe_area.dart";
import "../../../../widgets/loading_widgets/simple_previews/horizontal_rectangular_section_loading.dart";
import "../../../../widgets/loading_widgets/simple_previews/preview_card_loading.dart";
import "../../../../widgets/my_error_widget.dart";
import "../../../../widgets/text_and_url_widget.dart";
import "../../../bottom_scroll_sheet/drag_handle.dart";
import "../../sks_people_live/data/repository/latest_sks_user_data_repo.dart";
import "../data/models/sks_chart_data.dart";
import "../data/repository/sks_chart_repository.dart";
import "sks_chart_card.dart";

class SksChartSheet extends ConsumerWidget {
  const SksChartSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncChartData = ref.watch(sksChartRepositoryProvider);
    final asyncNumberOfUsers = ref.watch(getLatestSksUserDataProvider);

    final currentNumberOfUsers = asyncNumberOfUsers.value;
    final maxNumberOfUsers = asyncChartData.value?.maxNumberOfUsers ?? 0;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final sheetHeight = useFiltersSheetHeight(context, prefferedHeightFactor: screenWidth > 400 ? .72 : .84);

    return switch (asyncChartData) {
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncLoading() => _SksChartLoading(sheetHeight: sheetHeight),
      AsyncValue() => HorizontalSymmetricSafeArea(
        child: SizedBox(
          height: sheetHeight,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: SksChartConfig.paddingLargeLTR.copyWith(bottom: SksChartConfig.paddingMedium),
                child: const _SksSheetHeader(),
              ),
              Expanded(
                child: Semantics(
                  label: context.localize.sks_chart_title_screen_reader_label,
                  explicitChildNodes: true,
                  container: true,
                  child: SksChartCard(
                    currentNumberOfUsers: currentNumberOfUsers,
                    maxNumberOfUsers: maxNumberOfUsers,
                    chartData: asyncChartData.value ?? const IList.empty(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SksChartConfig.paddingSmall),
                child: TextAndUrl(
                  SksChartConfig.sksChartDataUrl,
                  "${context.localize.data_come_from_website}: ",
                  scaleText: false,
                ),
              ),
            ],
          ),
        ),
      ),
    };
  }
}

class _SksChartLoading extends StatelessWidget {
  const _SksChartLoading({required this.sheetHeight});

  final double sheetHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sheetHeight,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16).copyWith(bottom: 16),
            child: const HorizontalRectangularSectionLoading(),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: PreviewCardLoading(height: 300, width: double.infinity),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: PreviewCardLoading(height: 10, width: double.infinity),
          ),
        ],
      ),
    );
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
            textScaler: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 1.3),
          ),
        ),
      ],
    );
  }
}
