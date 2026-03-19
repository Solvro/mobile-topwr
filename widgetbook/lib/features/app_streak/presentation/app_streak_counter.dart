import "package:flutter/widgets.dart";
import "package:topwr/features/app_streak/presentation/app_streak_counter.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart" as widgetbook;

@widgetbook.UseCase(name: "default", type: AppStreakCounter)
Widget useCaseAppStreakCounter(BuildContext context) {
  return const AppStreakCounter();
}
