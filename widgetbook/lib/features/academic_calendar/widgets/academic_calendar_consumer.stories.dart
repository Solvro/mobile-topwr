import "package:flutter/material.dart";
import "package:topwr/features/academic_calendar/widgets/academic_calendar_consumer.dart";
import "package:widgetbook/widgetbook.dart";

part "academic_calendar_consumer.stories.g.dart";

const meta = Meta<AcademicCalendarConsumer>();

final $default = AcademicCalendarConsumerStory(
  setup: (context, child, args) => ColoredBox(color: Colors.white, child: child),
);
