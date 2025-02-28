import "package:flutter/foundation.dart";
import "package:flutter_cache_manager/flutter_cache_manager.dart";

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
  guideRepository,
  changelogRepository,
  plannerAdvertRepository,
  // ... add a new key here if you create a new repository
}

abstract class TtlStrategy {
  // no cache in debug mode
  static const day = kDebugMode ? Duration(minutes: 30) : Duration(days: 1);
  static const week = kDebugMode ? Duration(minutes: 30) : Duration(days: 7);
  static const thirtyDays = kDebugMode ? Duration(minutes: 30) : Duration(days: 30);

  static Duration get(TtlKey key) {
    return switch (key) {
      TtlKey.academicCalendarRepository => week,
      TtlKey.scienceClubDetailsRepository => week,
      TtlKey.scienceClubsRepository => week,
      TtlKey.tagsRepository => week,
      TtlKey.buildingsRepository => week,
      TtlKey.departmentsRepository => week,
      TtlKey.aboutUsRepository => week,
      TtlKey.departmentDetailsRepository => week,
      TtlKey.guideDetailsRepository =>
        day, // leaving as day for now, cause maybe some uni orgs will update it by themselves
      TtlKey.guideRepository => week,
      TtlKey.changelogRepository => week,
      TtlKey.plannerAdvertRepository => day,
    };
  }
}

abstract class MyCachedImageConfig {
  static const cacheKey = "topwr_my_cached_image_cache";
  static final cacheConfig = Config(cacheKey, stalePeriod: const Duration(days: 7));
}
