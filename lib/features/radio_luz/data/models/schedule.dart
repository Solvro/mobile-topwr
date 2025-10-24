import "package:freezed_annotation/freezed_annotation.dart";

part "schedule.freezed.dart";
part "schedule.g.dart";

class ThumbnailConverter implements JsonConverter<String?, dynamic> {
  const ThumbnailConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null || json == false) {
      return null;
    }
    if (json is String) {
      return json;
    }
    return null;
  }

  @override
  dynamic toJson(String? object) => object;
}

@freezed
abstract class Schedule with _$Schedule {
  const factory Schedule({required List<BroadcastBlock> broadcasts, required int week}) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);
}

@freezed
abstract class BroadcastBlock with _$BroadcastBlock {
  const factory BroadcastBlock({required int timeinmin, required List<Broadcast> broadcasts, bool? isNow}) =
      _BroadcastBlock;

  factory BroadcastBlock.fromJson(Map<String, dynamic> json) => _$BroadcastBlockFromJson(json);
}

@freezed
abstract class Broadcast with _$Broadcast {
  const factory Broadcast({
    required int id,
    required String time,
    @ThumbnailConverter() String? thumbnail,
    required String title,
    required String content,
    required String authors,
    required String permalink,
    required String week,
  }) = _Broadcast;

  factory Broadcast.fromJson(Map<String, dynamic> json) => _$BroadcastFromJson(json);
}
