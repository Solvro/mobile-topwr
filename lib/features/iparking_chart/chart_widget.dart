import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config.dart';
import '../../theme/app_theme.dart';
import '../../utils/context_extensions.dart';
import '../../widgets/loading_widgets/simple_previews/preview_card_loading.dart';
import '../../widgets/my_error_widget.dart';
import '../iparking/models/parking_model.dart';
import 'models/chart_point.dart';
import 'repositories/chart_repo.dart';
import 'widgets/ichart.dart';

class ParkingChart extends ConsumerWidget {
  const ParkingChart(this.parkingPlace, {super.key});

  final ParkingPlace parkingPlace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartData = ref.watch(chartRepoProvider.call(parkingPlace));
    return switch (chartData) {
      AsyncLoading() => Padding(
          padding: const EdgeInsets.only(
            top: 18,
            left: 8,
            right: 8,
            bottom: 10,
          ),
          child: PreviewCardLoading(
            height: double.infinity,
            width: double.infinity,
            color: context.colorTheme.greyPigeon.withOpacity(0.1),
          ),
        ),
      AsyncError(:final error) => Material(
          borderRadius: const BorderRadius.all(WideTileCardConfig.radius),
          color: context.colorTheme.greyLight.withOpacity(0.8),
          child: MyErrorWidget(error),
        ),
      AsyncValue(:final value) => Builder(builder: (context) {
          if (value == null) return const SizedBox.shrink();
          final chartPoints = value.toChartPoints().toList();
          if (chartPoints.isEmpty) {
            return Center(
              child: Text(
                context.localize.noChartData,
                style: context.iParkingTheme.subtitleLight,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 0,
              right: 25,
              bottom: 10,
            ),
            child: IChart(chartPoints, parkingPlace),
          );
        }),
    };
  }
}
