import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../models/history_entry.dart";
import "radio_luz_repository.dart";

part "history_entry_repository.g.dart";

@riverpod
Future<IList<HistoryEntry>?> historyEntryRepository(Ref ref) async {
  final repository = ref.read(radioLuzRepositoryProvider);

  final history = await repository.getRecentlyPlayed();
  if (history == null) {
    return null;
  }

  return history.toIList();
}
