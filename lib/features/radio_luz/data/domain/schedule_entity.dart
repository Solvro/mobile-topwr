import "package:freezed_annotation/freezed_annotation.dart";

import "../models/schedule.dart";

part 'schedule_entity.freezed.dart';
part 'schedule_entity.g.dart';

@freezed
abstract class BroadcastEntity with _$BroadcastEntity {
  const factory BroadcastEntity({
    required int id,
    required String time,
    required String thumbnail,
    required String title,
    required String content,
    required String authors,
    required String permalink,
    required String week,
    required bool isNow,
  }) = _BroadcastEntity;

  factory BroadcastEntity.fromJson(Map<String, dynamic> json) => _$BroadcastEntityFromJson(json);

  factory BroadcastEntity.fromDomain(Broadcast broadcast, {bool isNow = false}) {
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
  }
}
