import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/my_error_widget.dart';
import 'parking_card.dart';
import 'repositories/parkings_repo.dart';

class ParkingView extends ConsumerWidget {
  /// Placeholder widget to show how to use iparking module

  const ParkingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkings = ref.watch(parkingsRepoProvider);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(parkingsRepoProvider.future),
      child: Center(
        child: switch (parkings) {
          AsyncLoading() => const CircularProgressIndicator(),
          AsyncError(:final error) => MyErrorWidget(error),
          AsyncValue(:final value) => ListView.builder(
              itemCount: value?.length ?? 0,
              itemBuilder: (context, index) => ParkingCard(value![index]),
            ),
        },
      ),
    );
  }
}
