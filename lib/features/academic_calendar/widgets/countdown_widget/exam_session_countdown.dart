import "dart:async";

import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../config/ui_config.dart";
import "../../../../config/url_config.dart";
import "../../../../theme/app_theme.dart";
import "../../../../utils/context_extensions.dart";
import "../../../../utils/launch_url_util.dart";
import "../../../analytics/data/umami.dart";
import "../../../analytics/data/umami_events.dart";
import "../../repository/academic_calendar_repo.dart";
import "../../utils/counter_digits.dart";
import "../../utils/localize_counter_message.dart";
import "digits_widgets.dart";

class ExamSessionCountdown extends ConsumerWidget {
  const ExamSessionCountdown(this.academicCalendar, {super.key});

  final AcademicCalendar academicCalendar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaler = context.textScaler.clamp(maxScaleFactor: 2.5);
    const padding = 16.0;
    const initialHeight = 69.0;
    final height = scaler.scale(initialHeight - 2 * padding) + 2 * padding;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
      child: GestureDetector(
        onTap: () async {
          unawaited(ref.trackEvent(UmamiEvents.openAcademicCalendarExternalLink));
          await ref.launch(UrlConfig.academicCalendarUrl);
        },
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: context.colorTheme.toPwrGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(spreadRadius: 6, blurRadius: 11, color: Color(0x28fa6465))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Semantics(
                  label: academicCalendar.daysLeftFromNowString(usePadZeros: false),
                  child: ExcludeSemantics(child: DigitsRow(academicCalendar)),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(context.localize.days, style: context.textTheme.headlineWhite, maxLines: 1),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        academicCalendar.localizeDaysCounterMessage(context),
                        style: context.textTheme.bodyWhite,
                        textScaler: const TextScaler.linear(0.97),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(Icons.open_in_new_rounded, color: context.colorTheme.whiteSoap),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
