import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/context_extensions.dart';
import '../../../utils/format_weekday.dart';

class Greeting extends StatelessWidget {
  const Greeting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.localize!.home_screen_greeting,
              style: context.greetingTheme.textStyle),
          Text('${context.mapAcademicScheduleDay(DateTime.now())}!',
              style: context.greetingTheme.boldTextStyle),
        ],
      ),
    );
  }
}
