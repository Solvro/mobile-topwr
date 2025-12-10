import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_splash_tile.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";
import "day_changes_dialog.dart";

class IncomingDayChanges extends ConsumerWidget {
  const IncomingDayChanges({super.key, required this.calendar});
  final AcademicCalendarWithSwaps calendar;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = calendar.incomingDaysChanges(ref);
    if (data == null) {
      return const SizedBox.shrink();
    }
    final l10n = context.localize;

    final children = [
      Semantics(
        label: l10n.incoming_days_changes_summary(data.daysTillFirstChange, data.changesCount),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [context.colorScheme.primaryContainer, context.colorScheme.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.primary.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber, size: 18, color: context.colorScheme.surface),
              const SizedBox(width: 6),
              ExcludeSemantics(
                child: Text(
                  l10n.incoming_days_changes_days(data.daysTillFirstChange),
                  style: context.textTheme.titleLarge
                      ?.copyWith(color: context.colorScheme.surface)
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      ExcludeSemantics(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: data.daysTillFirstChange == 0
                    ? l10n.incoming_days_changes_title_today(data.changesCount)
                    : l10n.incoming_days_changes_title(data.changesCount),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.sizeOf(context).width > 380 ? 15 : 13,
                ),
              ),
              const TextSpan(text: " "),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.info_outline, size: 18, color: context.colorScheme.tertiary),
              ),
            ],
          ),
        ),
      ),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: context.isTextScaledUp
                  ? Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 12,
                      spacing: 12,
                      children: children,
                    )
                  : Row(spacing: 12, mainAxisAlignment: MainAxisAlignment.center, children: children),
            ),
            builder: (context, ref, child) => MySplashTile(
              backgroundColor: Colors.transparent,
              onTap: () async {
                await DayChangesDialog.show(context, calendar, ref);
              },
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
