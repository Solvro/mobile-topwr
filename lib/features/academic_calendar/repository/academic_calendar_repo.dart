import "dart:convert";

import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http/http.dart" as http;
import "package:riverpod_annotation/riverpod_annotation.dart";

part "academic_calendar_repo.g.dart";

// Model for one calendar entry
class AcademicCalendarData {
  final int id;
  final String name;
  final DateTime semesterStartDate;
  final DateTime examSessionStartDate; //
  final DateTime examSessionLastDate; //
  final bool isFirstWeekEven;
  final DateTime createdAt;
  final DateTime updatedAt;

  AcademicCalendarData({
    required this.id,
    required this.name,
    required this.semesterStartDate,
    required this.examSessionStartDate,
    required this.examSessionLastDate,
    required this.isFirstWeekEven,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcademicCalendarData.fromJson(Map<String, dynamic> json) {
    return AcademicCalendarData(
      id: json["id"] as int,
      name: json["name"] as String,
      semesterStartDate: DateTime.parse(json["semesterStartDate"] as String),
      examSessionStartDate: DateTime.parse(json["examSessionStartDate"] as String),
      examSessionLastDate: DateTime.parse(json["examSessionLastDay"] as String),
      isFirstWeekEven: json["isFirstWeekEven"] as bool,
      createdAt: DateTime.parse(json["createdAt"] as String),
      updatedAt: DateTime.parse(json["updatedAt"] as String),
    );
  }
}

// Model for the academic calendar
class AcademicCalendar {
  final IList<AcademicCalendarData> data;
  final IList<AcademicWeekException> weeks;

  AcademicCalendar({required this.data, required this.weeks});

  factory AcademicCalendar.fromJson(Map<String, dynamic> json) {
    final list =
        (json["data"] as List<dynamic>).map((e) => AcademicCalendarData.fromJson(e as Map<String, dynamic>)).toIList();
    final weeks =
        (json["weeks"] as List<dynamic>)
            .map((e) => AcademicWeekException.fromJson(e as Map<String, dynamic>))
            .toIList();

    return AcademicCalendar(data: list, weeks: weeks);
  }
}

@riverpod
Future<AcademicCalendar?> academicCalendarRepo(Ref ref) async {
  final client = http.Client();

  try {
    final response = await client.get(Uri.parse("https://api.topwr.solvro.pl/api/v1/academic_calendars"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;

      return AcademicCalendar.fromJson(json);
    } else {
      // handle non-200 response
      return null;
    }
  } on Exception {
    // handle network error
    return null;
  } finally {
    client.close();
  }
}

class AcademicWeekException {
  final int id;
  final int academicCalendarId;
  final DateTime day;
  final String changedWeekday;
  final bool changedDayIsEven;

  AcademicWeekException({
    required this.id,
    required this.academicCalendarId,
    required this.day,
    required this.changedWeekday,
    required this.changedDayIsEven,
  });

  factory AcademicWeekException.fromJson(Map<String, dynamic> json) {
    return AcademicWeekException(
      id: json["id"] as int,
      academicCalendarId: json["academicCalendarId"] as int,
      day: DateTime.parse(json["date"] as String),
      changedWeekday: json["changedWeekday"] as String,
      changedDayIsEven: json["changedDayIsEven"] as bool,
    );
  }
}

@riverpod
Future<IList<AcademicWeekException>?> academicWeekExceptionRepo(Ref ref) async {
  final client = http.Client();

  try {
    final response = await client.get(Uri.parse("https://api.topwr.solvro.pl/api/v1/day_swaps"));
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body) as List<dynamic>;
      return json.map((e) => AcademicWeekException.fromJson(e as Map<String, dynamic>)).toIList();
    } else {
      // handle non-200 response
      return null;
    }
  } on Exception {
    // handle network error
    return null;
  } finally {
    client.close();
  }
}

class WeekExceptions {
  static final IList<AcademicWeekException> _weekExceptions = IList(const []);

  static IList<AcademicWeekException> get lock => _weekExceptions;
}
