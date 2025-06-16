import "package:freezed_annotation/freezed_annotation.dart";

@JsonEnum(fieldRename: FieldRename.pascal)
enum WeekdayEnum {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  static WeekdayEnum fromJson(String json) => values.byName(json.toLowerCase());

  static WeekdayEnum fromDateTime(DateTime dateTime) {
    return switch (dateTime.weekday) {
      DateTime.monday => WeekdayEnum.monday,
      DateTime.tuesday => WeekdayEnum.tuesday,
      DateTime.wednesday => WeekdayEnum.wednesday,
      DateTime.thursday => WeekdayEnum.thursday,
      DateTime.friday => WeekdayEnum.friday,
      DateTime.saturday => WeekdayEnum.saturday,
      DateTime.sunday => WeekdayEnum.sunday,
      _ => WeekdayEnum.monday,
    };
  }
}
