// ignore_for_file: dead_code, literal_only_boolean_expressions
import "package:dio/dio.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../api_base_rest/client/dio_client.dart";
import "../../../../config/env.dart";
import "../models/activity_days_response.dart";

part "activity_days_repository.g.dart";

@riverpod
Future<ActivityDaysResponse?> activityDaysRepository(Ref ref) async {
  final now = DateTime.now();
  if (true) {
    return ActivityDaysResponse(
      id: 999,
      name: "Wiosenne Dni Aktywności Studenckiej",
      startsAt: now.subtract(const Duration(days: 1)),
      endsAt: now.add(const Duration(days: 2)),
      createdAt: now.subtract(const Duration(days: 30)),
      updatedAt: now.subtract(const Duration(days: 5)),
      timetable: const ActivityDaysTimetable(id: 1, description: "Harmonogram DAS"),
      maps: const [ActivityDaysMap(id: 1, name: "Mapa główna")],
      links: const [ActivityDaysLink(id: 1, url: "https://pwr.edu.pl")],
      stands: const [
        ActivityDaysStand(id: 1, name: "Koło Naukowe Solvro"),
        ActivityDaysStand(id: 2, name: "PWR Racing Team"),
      ],
    );
  }

  final restClient = ref.watch(restClientProvider);
  final url = "${Env.mainRestApiUrl}/das";

  try {
    final response = await restClient.get<List<dynamic>>(url);
    final data = response.data;
    if (data == null || data.isEmpty) return null;

    final now = DateTime.now();
    final events = data.whereType<Map<String, dynamic>>().map(ActivityDaysResponse.fromJson).toList();

    final runningEvents = events.where((e) => now.isAfter(e.startsAt) && now.isBefore(e.endsAt));
    if (runningEvents.isNotEmpty) {
      return runningEvents.first;
    }

    final upcomingEvents = events.where((e) => e.startsAt.isAfter(now)).toList()
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    if (upcomingEvents.isNotEmpty) {
      return upcomingEvents.first;
    }

    return null;
  } on DioException {
    return null;
  }
}

@riverpod
Future<bool> isActivityDaysActive(Ref ref) async {
  final event = await ref.watch(activityDaysRepositoryProvider.future);
  if (event == null) return false;

  final now = DateTime.now();
  return now.isAfter(event.startsAt) && now.isBefore(event.endsAt);
}
