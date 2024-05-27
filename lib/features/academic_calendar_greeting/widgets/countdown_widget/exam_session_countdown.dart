import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../../../../widgets/my_error_widget.dart';
import '../../../home_view/widgets/loading_widgets/horizontal_rectangular_section_loading.dart';
import '../../repository/academic_calendar_repo.dart';
import 'digits_widgets.dart';

class ExamSessionCountdown extends ConsumerWidget {
  const ExamSessionCountdown({super.key});

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
          child: Container(
            width: double.infinity,
            height: 69,
            decoration: BoxDecoration(
              gradient: context.colorTheme.toPwrGradient,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  spreadRadius: 6,
                  blurRadius: 11,
                  color: Color(0x28fa6465),
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: DigitsRow(value),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localize.days,
                      style: context.textTheme.headlineWhite,
                    ),
                    Text(
                      context.localize.to_start_session,
                      style: context.textTheme.bodyWhite,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
    };
  }
}
