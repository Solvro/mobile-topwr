import 'package:enum_map/enum_map.dart';

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
  weekParityExceptionsRepository
  // ... add a new key here if you create a new repository
}

abstract class TtlStrategy {
  static const day = Duration(days: 0);
  static const week = Duration(days: 0);
  static const thirtyDays = Duration(days: 0);

  static const _ttlDurations = UnmodifiableTtlKeyMap(
    // TODO: specific values are yet ment to be accordingly adjusted
    infosPreviewRepository: day,
    academicCalendarRepository: day,
    sciCirclesPreviewRepository: thirtyDays,
    sciCirclesRepository: thirtyDays,
    tagsRepository: thirtyDays,
    mapBuildingsRepository: thirtyDays,
    departmentsRepository: thirtyDays,
    weekParityExceptionsRepository: thirtyDays,
  );

  static Duration get(TtlKey key) {
    return _ttlDurations.get(key);
  }
}
