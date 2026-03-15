import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:topwr/features/radio_luz/data/models/history_entry.dart";
import "package:topwr/features/radio_luz/data/repository/history_entry_repository.dart";

void main() {
  group("HistoryEntryRepository (integration test)", () {
    test("Fetching data from api", () async {
      final container = ProviderContainer(
<<<<<<< HEAD
        overrides: [radioTrackChangedProvider.overrideWith((_) => const Stream<String>.empty())],
=======
        overrides: [radioTrackChangedProvider.overrideWithValue(const Stream<String>.empty())],
>>>>>>> e9b680b0 (chore: format)
      );
      addTearDown(container.dispose);

      final scheduleFuture = container.read(historyEntryRepositoryProvider.future);

      final entries = await scheduleFuture;

      expect(entries, isA<IList<HistoryEntry>?>());
      expect(entries, isNotEmpty);

      final first = entries!.first;
      debugPrint("✅ Pierwszy utwór: ${first.artist} – ${first.title} (${first.date} ${first.time})");
    });
  });
}
