import "package:flutter/material.dart";
import "../../../theme/app_theme.dart";
import "../../../widgets/my_splash_tile.dart";
import "../model/academic_calendar_extensions.dart";
import "../repository/academic_calendar_repo.dart";

class IncomingDayChanges extends StatelessWidget {
  const IncomingDayChanges({super.key, required this.calendar});
  final AcademicCalendar calendar;
  @override
  Widget build(BuildContext context) {
    final data = calendar.incomingDaysChanges;
    if (data == null) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: MySplashTile(
        backgroundColor: Colors.transparent,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                    Text(
                      "${data.daysTillFirstChange} dni",
                      style: context.textTheme.bodyWhite.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Nadchodzące ${data.changesCount} zmiany dnia!",
                style: context.textTheme.body.copyWith(fontWeight: FontWeight.w500, fontSize: 15),
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
