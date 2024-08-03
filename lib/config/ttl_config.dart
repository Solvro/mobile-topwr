import "package:enum_map/enum_map.dart";
import "package:flutter/foundation.dart";

part "ttl_config.g.dart";

@unmodifiableEnumMap
enum TtlKey {
  /// We need unique key for every data source for its ttl tracking
  academicCalendarRepository,
  newsRepository,
  scienceClubsRepository,
  scienceClubDetailsRepository,
  tagsRepository,
  departmentsRepository,
  departmentDetailsRepository,
  aboutUsRepository,
  buildingsRepository,
  // ... add a new key here if you create a new repository
}

abstract class TtlStrategy {
  // no cache in debug mode
  static const day = kDebugMode ? Duration.zero : Duration(days: 1);
  static const week = kDebugMode ? Duration.zero : Duration(days: 7);
  static const thirtyDays = kDebugMode ? Duration.zero : Duration(days: 30);

  static const _ttlDurations = UnmodifiableTtlKeyMap(
    // TODO(simon-the-shark): specific values are yet ment to be accordingly adjusted.
    newsRepository: day,
    academicCalendarRepository: day,
    scienceClubDetailsRepository: thirtyDays,
    scienceClubsRepository: thirtyDays,
    tagsRepository: thirtyDays,
    buildingsRepository: thirtyDays,
    departmentsRepository: thirtyDays,
    aboutUsRepository: thirtyDays,
    departmentDetailsRepository: thirtyDays,
  );

  static Duration get(TtlKey key) {
    return _ttlDurations.get(key);
  }
}
