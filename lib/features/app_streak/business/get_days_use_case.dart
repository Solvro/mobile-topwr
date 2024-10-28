import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/datetime_utils.dart";
import "../../../utils/timestamp.dart";
import "../data/last_entry_repo.dart";
import "../data/streak_start_repo.dart";

part "get_days_use_case.g.dart";

@riverpod
Future<int> getUsageDaysUseCase(Ref ref) async {
  final today = Timestamp.now().date;
  final lastEntry = (await ref.watch(lastEntryRepositoryProvider.future)).date;
  final differenceFromLastEntry = today.difference(lastEntry).inDays;
  if (differenceFromLastEntry > 1) {
    await ref.read(streakStartRepositoryProvider.notifier).resetStamp();
    return 1;
  }
  final startStreakDate =
      (await ref.watch(streakStartRepositoryProvider.future)).date;
  final daysUsing = today.difference(startStreakDate).inDays + 1;
  await ref.read(lastEntryRepositoryProvider.notifier).resetStamp();
  return daysUsing;
}
