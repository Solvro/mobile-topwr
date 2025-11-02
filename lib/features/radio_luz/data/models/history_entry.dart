import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "history_entry.freezed.dart";
part "history_entry.g.dart";

class TimeOfDayConverter implements JsonConverter<TimeOfDay, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(String json) {
    final parts = json.split(":");
    final hour = int.tryParse(parts.isNotEmpty ? parts[0] : "") ?? 0;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : "") ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  String toJson(TimeOfDay time) {
    final h = time.hour.toString().padLeft(2, "0");
    final m = time.minute.toString().padLeft(2, "0");
    return "$h:$m";
  }
}

@freezed
abstract class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required String date,
    @TimeOfDayConverter() required TimeOfDay time,
    required String artist,
    required String title,
    required String album,
    required String duration,
    required String label,
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => _$HistoryEntryFromJson(json);

  factory HistoryEntry.fromList(List<dynamic> data) {
    final timeParts = (data[1] as String).split(":");
    final hour = int.tryParse(timeParts[0]) ?? 0;
    final minute = int.tryParse(timeParts[1]) ?? 0;
    final time = TimeOfDay(hour: hour, minute: minute);

    return HistoryEntry(
      date: data[0] as String,
      time: time,
      artist: data[2] as String,
      title: data[3] as String,
      album: data[4] as String,
      duration: data[5] as String,
      label: data[6] as String,
    );
  }
}
