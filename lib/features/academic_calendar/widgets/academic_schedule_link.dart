import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../config/ui_config.dart";
import "../../../config/url_config.dart";
import "../../../services/haptics/app_haptics.dart";
import "../../../theme/app_theme.dart";
import "../../../utils/context_extensions.dart";
import "../../../utils/launch_url_util.dart";

class AcademicScheduleLink extends ConsumerWidget {
  const AcademicScheduleLink({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.paddingLarge),
      child: Material(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: AppHaptics.wrapperLight(() => ref.launch(UrlConfig.academicCalendarUrl)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: context.colorScheme.onPrimaryContainer,
                  semanticLabel: context.localize.kill_switch_schedule_title,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localize.kill_switch_schedule_title,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        context.localize.kill_switch_schedule_subtitle,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.open_in_new_rounded,
                  color: context.colorScheme.onPrimaryContainer,
                  semanticLabel: context.localize.kill_switch_schedule_title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
