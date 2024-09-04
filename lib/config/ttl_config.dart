import "package:enum_map/enum_map.dart";
import "package:flutter/foundation.dart";

part "ttl_config.g.dart";

@unmodifiableEnumMap
enum TtlKey {
  /// We need unique key for every data source for its ttl tracking
  academicCalendarRepository,
  scienceClubsRepository,
  scienceClubDetailsRepository,
  tagsRepository,
  departmentsRepository,
  departmentDetailsRepository,
  aboutUsRepository,
  buildingsRepository,
  guideDetailsRepository,
  guideRepository
  // ... add a new key here if you create a new repository
}

abstract class TtlStrategy {
  // no cache in debug mode
  static const day = kDebugMode ? Duration(seconds: 30) : Duration(days: 1);
  static const week = kDebugMode ? Duration(seconds: 30) : Duration(days: 7);
  static const thirtyDays =
      kDebugMode ? Duration(seconds: 30) : Duration(days: 30);

  static const _ttlDurations = UnmodifiableTtlKeyMap(
    // TODO(simon-the-shark): specific values are yet ment to be accordingly adjusted.
    academicCalendarRepository: day,
    scienceClubDetailsRepository: day,
    scienceClubsRepository: day,
    tagsRepository: day,
    buildingsRepository: day,
    departmentsRepository: day,
    aboutUsRepository: day,
    departmentDetailsRepository: day,
    guideDetailsRepository: day,
    guideRepository: day,
  );

  static Duration get(TtlKey key) {
    return _ttlDurations.get(key);
  }
}
