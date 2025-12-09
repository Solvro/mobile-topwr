import "package:flutter_cache_manager/flutter_cache_manager.dart";

/// all ttl days available options for cache manager
/// you can add more ttl days here if you need it
enum TtlDays {
  /// month / 30 days
  defaultDigitalGuide(30),

  /// week / 7 days
  defaultDefault(7),

  /// day / 1 day
  defaultSks(1);

  const TtlDays(this.days);

  final int days;
}

// my cached image package config for cache pruning
abstract class MyCachedImageConfig {
  static const cacheKey = "topwr_my_cached_image_cache";
  static final cacheConfig = Config(cacheKey, stalePeriod: const Duration(days: 7));
}
