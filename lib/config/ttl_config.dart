import "package:flutter_cache_manager/flutter_cache_manager.dart";

/// all ttl days available options for cache manager
/// you can add more ttl days here if you need it
enum TtlDays {
  /// month / 30 days
  defaultDigitalGuide(30, 0, 0),

  /// week / 7 days
  defaultDefault(7, 0, 0),

  /// day / 1 day
  defaultSks(1, 0, 0),

  /// hour / 1 hour
  defaultOneHour(0, 1, 0),

  /// one minute
  defaultOneMinute(0, 0, 1);

  const TtlDays(this.days, this.hours, this.minutes);

  final int days;
  final int hours;
  final int minutes;

  Duration get duration => Duration(days: days, hours: hours, minutes: minutes);
}

// my cached image package config for cache pruning
abstract class MyCachedImageConfig {
  static const cacheKey = "topwr_my_cached_image_cache";
  static final cacheConfig = Config(cacheKey, stalePeriod: const Duration(days: 7));
}
