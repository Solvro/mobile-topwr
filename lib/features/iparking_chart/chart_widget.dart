import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/app_theme.dart';
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
      AsyncError(:final error) => MyErrorWidget(error.toString()),
      AsyncValue(:final value) => value == null
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 0,
                right: 25,
                bottom: 10,
              ),
              child: IChart(value.toChartPoints().toList(), parkingPlace),
            ),
    };
  }
}
