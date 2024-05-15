import '../../../api_base/schema.graphql.dart';


typedef ParityEnum = Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_PARITY;
extension ParityExtension on ParityEnum {
  bool get isEven {
    switch (this) {
      case ParityEnum.Even:
        return true;
      case ParityEnum.Odd:
      case ParityEnum.$unknown:
      default:
        return false;
    }
  }
}

typedef WeekEnum = Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK;

extension DayOfWeekExtension on WeekEnum {
  int get toDateTimeWeekday {
    switch (this) {
      case WeekEnum.Mon:
        return DateTime.monday;
      case WeekEnum.Tue:
        return DateTime.tuesday;
      case WeekEnum.Wed:
        return DateTime.wednesday;
      case WeekEnum.Thu:
        return DateTime.thursday;
      case WeekEnum.Fri:
        return DateTime.friday;
      case WeekEnum.Sat:
        return DateTime.saturday;
      case WeekEnum.Sun:
        return DateTime.sunday;
      case WeekEnum.$unknown:
      default:
        throw Exception('Unknown weekday');
    }
  }
}