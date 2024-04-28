import 'package:enum_map/enum_map.dart';

part 'ttl_config.g.dart';

@unmodifiableEnumMap
enum TtlKey {
  /// We need unique key for every data source for its ttl tracking
  sciCirclesPreviewRepository,
  examSessionCountdownRepository,
  infosPreviewRepository,
  sciCirclesRepository,
  tagsRepository,
  mapBuildingsRepository,
  departmentsRepository,
  // ... add a new key here if you create a new repository
}

abstract class TtlStrategy {
  static const day = Duration(days: 1);
  static const week = Duration(days: 7);
  static const thirtyDays = Duration(days: 30);

  static const _ttlDurations = UnmodifiableTtlKeyMap(
    // TODO: specific values are yet ment to be accordingly adjusted
    infosPreviewRepository: day,
    examSessionCountdownRepository: day,
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
