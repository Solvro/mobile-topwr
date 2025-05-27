import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../theme/iparking_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/loading_widgets/simple_previews/preview_card_loading.dart";
import "../../../widgets/my_error_widget.dart";
import "../parkings_view/models/parking.dart";
import "models/chart_point.dart";
import "repository/chart_repository.dart";
import "widgets/chart_widget.dart";

class ParkingChart extends ConsumerWidget {
  const ParkingChart(this.parking, {super.key});

  final Parking parking;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 0.1);
    final chartData = ref.watch(chartRepositoryProvider(parking));
    return switch (chartData) {
      AsyncError(:final error) => Material(
        borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
        color: context.colorTheme.greyLight.withValues(alpha: 0.8),
        child: MyErrorWidget(error),
      ),
      AsyncValue(:final IList<ChartPoint> value) =>
        value.isEmpty
            ? Center(
              child: Text(context.localize.noChartData, style: context.iParkingTheme.subtitleLight.withoutShadows),
            )
            : Padding(
              padding: EdgeInsets.only(top: scaler.scale(14), right: scaler.scale(25), bottom: scaler.scale(9)),
              child: ChartWidget(value, parking),
            ),
      _ => Padding(
        padding: EdgeInsets.only(
          top: scaler.scale(18),
          left: scaler.scale(8),
          right: scaler.scale(8),
          bottom: scaler.scale(10),
        ),
        child: PreviewCardLoading(
          height: double.infinity,
          width: double.infinity,
          color: context.colorTheme.greyPigeon.withValues(alpha: 0.1),
        ),
      ),
    };
  }
}
