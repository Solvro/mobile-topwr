import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../widgets/my_error_widget.dart';
import '../../home_view/widgets/loading_widgets/horizontal_rectangular_section_loading.dart';
import '../model/academic_calendar_data.dart';
import '../repository/academic_calendar_repo.dart';
import '../utils/localize_academic_day.dart';

class Greeting extends ConsumerWidget {
  const Greeting({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(academicCalendarRepoProvider);

    return switch (state) {
      AsyncLoading() => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HorizontalRectangularSectionLoading(),
        ),
      AsyncError(:final error) => MyErrorWidget(error),
      AsyncValue(:final value) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.localize.home_screen_greeting,
                style: context.greetingTheme.textStyle,
              ),
              Text(
                value?.academicDay?.localize(context) ?? "",
                style: context.greetingTheme.boldTextStyle,
              ),
            ],
          ),
        )
    };
  }
}
