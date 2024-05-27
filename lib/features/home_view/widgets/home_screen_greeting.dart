import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/my_error_widget.dart';
import '../repositories/week_parity_exceptions_repository/get_week_parity_exceptions_repository.dart';
import '../../academic_calendar_greeting/utils/format_weekday.dart';
import 'loading_widgets/horizontal_rectangular_section_loading.dart';

class Greeting extends ConsumerWidget {
  const Greeting({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getWeekParityExceptionsRepositoryProvider);

    return switch (state) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HorizontalRectangularSectionLoading()),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.localize.home_screen_greeting,
                  style: context.greetingTheme.textStyle),
              Text('${context.mapAcademicScheduleDay(DateTime.now(), value)}!',
                  style: context.greetingTheme.boldTextStyle),
            ],
          ),
        )
    };
  }
}
