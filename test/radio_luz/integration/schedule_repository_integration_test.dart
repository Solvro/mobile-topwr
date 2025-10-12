import "package:flutter/foundation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:topwr/features/radio_luz/data/models/schedule.dart";
import "package:topwr/features/radio_luz/data/repository/schedule_repository.dart";

void main() {
  group("ScheduleRepository (integration test)", () {
    test("Fetching data from API", () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final scheduleFuture = container.read(scheduleRepositoryProvider.future);

      final schedule = await scheduleFuture;

      expect(schedule, isA<Schedule?>());
      expect(schedule, isNotNull);
      expect(schedule!.broadcasts, isNotEmpty);

      final firstBlock = schedule.broadcasts.first;
      final firstBroadcast = firstBlock.broadcasts.first;

      debugPrint("✅ Pierwszy blok: timeinmin=${firstBlock.timeinmin}, isNow=${firstBlock.isNow}");
      debugPrint("✅ Pierwsza audycja: ${firstBroadcast.title} (${firstBroadcast.time})");
    });
  });
}
