import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'parking_card.dart';
import 'repositories/parkings_repo.dart';

class ParkingView extends ConsumerWidget {
  const ParkingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkings = ref.watch(parkingsRepoProvider);
    return RefreshIndicator(
      onRefresh: () => ref.refresh(parkingsRepoProvider.future),
      child: Center(
        child: switch (parkings) {
          AsyncLoading() => const CircularProgressIndicator(),
          AsyncError(:final error, :final stackTrace) =>
            Text(error.toString() + stackTrace.toString()),
          AsyncValue(:final value) => ListView.builder(
              itemCount: value?.length ?? 0,
              itemBuilder: (context, index) => ParkingCard(value![index]),
            ),
        },
      ),
    );
  }
}
