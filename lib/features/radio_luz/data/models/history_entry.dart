import "package:freezed_annotation/freezed_annotation.dart";

part "history_entry.freezed.dart";
part "history_entry.g.dart";

@freezed
abstract class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required String date,
    required String time,
    required String artist,
    required String title,
    required String album,
    required String duration,
    required String label,
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => _$HistoryEntryFromJson(json);

  factory HistoryEntry.fromList(List<dynamic> data) {
    return HistoryEntry(
      date: data[0] as String,
      time: data[1] as String,
      artist: data[2] as String,
      title: data[3] as String,
      album: data[4] as String,
      duration: data[5] as String,
      label: data[6] as String,
    );
  }
}
