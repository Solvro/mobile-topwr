import "dart:convert";

import "package:dio/dio.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../client/radio_luz_client.dart";
import "../domain/schedule_entity.dart";
import "../models/schedule.dart";

part "schedule_repository.g.dart";

@riverpod
Future<List<BroadcastEntity>?> scheduleRepository(Ref ref) async {
  final dio = ref.read(radioLuzClientProvider);

  final formData = FormData.fromMap({"action": "schedule"});

  final response = await dio.post<String>("admin-ajax.php", data: formData);

  final rawData = response.data;

  if (rawData == null) {
    return null;
  }

  final jsonMap = jsonDecode(rawData) as Map<String, dynamic>;

  final schedule = Schedule.fromJson(jsonMap);

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
