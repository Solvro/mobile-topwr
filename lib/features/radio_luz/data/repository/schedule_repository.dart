import "package:riverpod_annotation/riverpod_annotation.dart";

import "../domain/schedule_entity.dart";
import "radio_luz_repository.dart";

part "schedule_repository.g.dart";

@riverpod
Future<List<BroadcastEntity>?> scheduleRepository(Ref ref) async {
  final repository = ref.read(radioLuzRepositoryProvider);

  final schedule = await repository.getSchedule();

  if (schedule == null) {
    return null;
  }

  return schedule.broadcasts
      .expand(
        (block) => block.broadcasts.map((broadcast) {
          final isNow = block.isNow ?? false;
          return BroadcastEntity(
            id: broadcast.id,
            time: broadcast.time,
            thumbnail: broadcast.thumbnail ?? "",
            title: broadcast.title,
            content: broadcast.content,
            authors: broadcast.authors,
            permalink: broadcast.permalink,
            week: broadcast.week,
            isNow: isNow,
          );
        }),
      )
      .toList();
}
