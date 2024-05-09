import '../api_base/schema.graphql.dart';

extension ParityExtension on Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_PARITY {
  bool get isEven {
    switch (this) {
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_PARITY.Even:
        return true;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_PARITY.Odd:
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_PARITY.$unknown:
      default:
        return false;
    }
  }
}

extension DayOfWeekExtension on Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK {
  int get toDateTimeWeekday {
    switch (this) {
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.Mon:
        return DateTime.monday;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.Tue:
        return DateTime.tuesday;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.Wed:
        return DateTime.wednesday;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.Thu:
        return DateTime.thursday;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.Fri:
        return DateTime.friday;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.Sat:
        return DateTime.saturday;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.Sun:
        return DateTime.sunday;
      case Enum$ENUM_COMPONENTWEEKDAYWEEKDAY_DAYOFTHEWEEK.$unknown:
      default:
        throw Exception('Unknown weekday');
    }
  }
}