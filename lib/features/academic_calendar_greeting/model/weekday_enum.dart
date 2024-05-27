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
    return switch (dateTime.weekday) {
      DateTime.monday => WeekdayEnum.mon,
      DateTime.tuesday => WeekdayEnum.tue,
      DateTime.wednesday => WeekdayEnum.wed,
      DateTime.thursday => WeekdayEnum.thu,
      DateTime.friday => WeekdayEnum.fri,
      DateTime.saturday => WeekdayEnum.sat,
      DateTime.sunday => WeekdayEnum.sun,
      _ => WeekdayEnum.mon,
    };
  }
}
