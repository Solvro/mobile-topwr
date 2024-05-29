import 'package:enum_map/enum_map.dart';
import 'package:flutter/foundation.dart';

part 'ttl_config.g.dart';

@unmodifiableEnumMap
enum TtlKey {
  /// We need unique key for every data source for its ttl tracking
  sciCirclesPreviewRepository,
  academicCalendarRepository,
  infosPreviewRepository,
  sciCirclesRepository,
  tagsRepository,
  mapBuildingsRepository,
  departmentsRepository,
  // ... add a new key here if you create a new repository
}

abstract class TtlStrategy {
  // no cache in debug mode
  static const day = kDebugMode ? Duration.zero : Duration(days: 1);
  static const week = kDebugMode ? Duration.zero : Duration(days: 7);
  static const thirtyDays = kDebugMode ? Duration.zero : Duration(days: 30);

  static const _ttlDurations = UnmodifiableTtlKeyMap(
    // TODO: specific values are yet ment to be accordingly adjusted
    infosPreviewRepository: day,
    academicCalendarRepository: day,
    sciCirclesPreviewRepository: thirtyDays,
    sciCirclesRepository: thirtyDays,
    tagsRepository: thirtyDays,
    mapBuildingsRepository: thirtyDays,
    departmentsRepository: thirtyDays,
  );

  static Duration get(TtlKey key) {
    return _ttlDurations.get(key);
  }
}
