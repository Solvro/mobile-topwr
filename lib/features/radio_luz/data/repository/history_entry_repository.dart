import "dart:convert";

import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../client/radio_luz_client.dart";
import "../models/history_entry.dart";

part "history_entry_repository.g.dart";

@riverpod
Future<IList<HistoryEntry>?> historyEntryRepository(Ref ref) async {
  final dio = ref.read(radioLuzClientProvider);

  final formData = FormData.fromMap({"action": "histoprylog"});

  final response = await dio.post<String>("admin-ajax.php", data: formData);

  final rawData = response.data;

  if (rawData == null) {
    return null;
  }
  final data = jsonDecode(rawData) as List<dynamic>;

  return data.map((e) => HistoryEntry.fromList(e as List<dynamic>)).toIList();
}
