import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart" show Provider;
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../utils/ref_extensions.dart";
import "../../service/radio_player_provider.dart";
import "../models/history_entry.dart";
import "radio_luz_repository.dart";

part "history_entry_repository.g.dart";

final radioTrackChangedProvider = Provider<Stream<String>>((ref) {
  return ref.read(radioPlayerProvider).trackChanged;
});

@riverpod
Future<IList<HistoryEntry>?> historyEntryRepository(Ref ref) async {
  ref.setRefresh(const Duration(seconds: 60));

  final trackStream = ref.read(radioTrackChangedProvider);
  final sub = trackStream.listen((_) => ref.invalidateSelf());
  ref.onDispose(sub.cancel);

  final repository = ref.watch(radioLuzRepositoryProvider);

  final history = await repository.getRecentlyPlayed();
  if (history == null) {
    return null;
  }

  return history.toIList();
}
