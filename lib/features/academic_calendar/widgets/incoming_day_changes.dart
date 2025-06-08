import "package:flutter/material.dart";
import "../../../config/ui_config.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../widgets/my_splash_tile.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";
import "day_changes_dialog.dart";

class IncomingDayChanges extends StatelessWidget {
  const IncomingDayChanges({super.key, required this.calendar});
  final AcademicCalendar calendar;
  @override
  Widget build(BuildContext context) {
    final data = calendar.incomingDaysChanges;
    if (data == null) {
      return const SizedBox.shrink();
    }
    final l10n = context.localize;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
      child: MySplashTile(
        backgroundColor: Colors.transparent,
        onTap: () async {
          await DayChangesDialog.show(context, calendar);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                label: l10n.incoming_days_changes_summary(data.daysTillFirstChange, data.changesCount),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [context.colorTheme.orangePomegranadeLighter, context.colorTheme.orangePomegranade],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: context.colorTheme.orangePomegranade.withValues(alpha: 0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.warning_amber, size: 18, color: context.colorTheme.whiteSoap),
                      const SizedBox(width: 6),
                      ExcludeSemantics(
                        child: Text(
                          l10n.incoming_days_changes_days(data.daysTillFirstChange),
                          style: context.textTheme.bodyWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ExcludeSemantics(
                child: Text(
                  data.daysTillFirstChange == 0
                      ? l10n.incoming_days_changes_title_today(data.changesCount)
                      : l10n.incoming_days_changes_title(data.changesCount),
                  style: context.textTheme.body.copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.info_outline, size: 18, color: context.colorTheme.greyPigeon),
            ],
          ),
        ),
      ),
    );
  }
}
