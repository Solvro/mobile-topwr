import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum WeekdayEnum {
  mon,
  tue,
  wed,
  thu,
  fri,
  sat,
  sun;

  static WeekdayEnum fromJson(String json) => values.byName(json);

  static WeekdayEnum fromDateTime(DateTime dateTime) {
    switch (dateTime.weekday) {
      case DateTime.monday:
        return WeekdayEnum.mon;
      case DateTime.tuesday:
        return WeekdayEnum.tue;
      case DateTime.wednesday:
        return WeekdayEnum.wed;
      case DateTime.thursday:
        return WeekdayEnum.thu;
      case DateTime.friday:
        return WeekdayEnum.fri;
      case DateTime.saturday:
        return WeekdayEnum.sat;
      case DateTime.sunday:
        return WeekdayEnum.sun;
      default:
        throw ArgumentError('Invalid weekday');
    }
  }
}
