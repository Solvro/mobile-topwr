import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../business/get_days_use_case.dart";

class AppStreakCounter extends ConsumerWidget {
  const AppStreakCounter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = ref.watch(getUsageDaysUseCaseProvider);
    return switch (days) {
      AsyncData(:final int value) => Center(
          child: Text(
            context.localize.streak_counter(value),
            style: context.textTheme.lightTitle.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
