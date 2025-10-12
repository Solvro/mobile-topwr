import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:topwr/features/radio_luz/data/models/history_entry.dart";
import "package:topwr/features/radio_luz/data/repository/history_entry_repository.dart";

void main() {
  group("ScheduleRepository (integration test)", () {
    test("Fetching data from api", () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final scheduleFuture = container.read(historyEntryRepositoryProvider.future);

      final entries = await scheduleFuture;

      expect(entries, isA<List<HistoryEntry>?>());
      expect(entries, isNotEmpty);

      final first = entries!.first;
      debugPrint("✅ Pierwszy utwór: ${first.artist} – ${first.title} (${first.date} ${first.time})");
    });
  });
}
