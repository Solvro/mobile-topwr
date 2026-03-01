import "dart:convert";

import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../client/radio_luz_client.dart";
import "../models/history_entry.dart";
import "../models/now_playing.dart";
import "../models/schedule.dart";

part "radio_luz_repository.g.dart";

class RadioLuzRepository {
  final Dio _dio;

  RadioLuzRepository(this._dio);

  Future<NowPlaying?> getNowPlaying() async {
    final rawData = await _fetchRawData("nowPlaying");
    if (rawData == null) return null;

    final dynamic decoded = jsonDecode(rawData);
    if (decoded is! Map<String, dynamic>) return null;

    return NowPlaying.fromJson(decoded);
  }

  Future<List<HistoryEntry>?> getRecentlyPlayed() async {
    final rawData = await _fetchRawData("histoprylog");
    if (rawData == null) return null;

    final dynamic decoded = jsonDecode(rawData);
    if (decoded is! List) return null;

    final rows = decoded.whereType<List<dynamic>>().toList();
    if (rows.length != decoded.length) return null;

    return rows.map(HistoryEntry.fromList).toList();
  }

  Future<Schedule?> getSchedule() async {
    final rawData = await _fetchRawData("schedule");
    if (rawData == null) return null;

    final dynamic decoded = jsonDecode(rawData);
    if (decoded is! Map<String, dynamic>) return null;

    return Schedule.fromJson(decoded);
  }

  Future<String?> _fetchRawData(String action) async {
    final formData = FormData.fromMap({"action": action});
    final response = await _dio.post<String>("admin-ajax.php", data: formData);
    return response.data;
  }
}

@riverpod
RadioLuzRepository radioLuzRepository(Ref ref) {
  final dio = ref.watch(radioLuzClientProvider);
  return RadioLuzRepository(dio);
}
