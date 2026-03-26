import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../utils/ref_extensions.dart";
import "../../service/radio_player_provider.dart";
import "../models/history_entry.dart";
import "radio_luz_repository.dart";

part "history_entry_repository.g.dart";

@riverpod
Stream<String> radioTrackChanged(Ref ref) {
  return ref.watch(radioPlayerProvider).trackChanged;
}

@riverpod
Future<IList<HistoryEntry>?> historyEntryRepository(Ref ref) async {
  ref.setRefresh(const Duration(seconds: 60));

  ref.listen(radioTrackChangedProvider, (_, next) {
    if (next.hasValue) ref.invalidateSelf();
  });

  final repository = ref.watch(radioLuzRepositoryProvider);

  final history = await repository.getRecentlyPlayed();
  if (history == null) {
    return null;
  }

  return history.toIList();
}
