import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:topwr/features/radio_luz/data/domain/schedule_entity.dart";
import "package:topwr/features/radio_luz/data/repository/schedule_repository.dart";

void main() {
  group("ScheduleRepository (integration test)", () {
    test("Fetching data from API", () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final scheduleFuture = container.read(scheduleRepositoryProvider.future);

      final schedule = await scheduleFuture;

      expect(schedule, isA<List<BroadcastEntity>>());
      expect(schedule, isNotNull);
      expect(schedule, isNotEmpty);
    });
  });
}
