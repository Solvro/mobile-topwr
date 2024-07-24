import "../../config/ttl_config.dart";
import "../../utils/timestamp.dart";

class TimestampTtl extends Timestamp {
  TimestampTtl.nil(this.key) : super.nil();
  TimestampTtl.from(super.ts, this.key) : super.from();
  TimestampTtl.tryParse(super.formattedString, this.key)
      : super.tryParse();

  final TtlKey key;

  Duration get ttl => TtlStrategy.get(key);

  Future<Duration> get timeAgo async {
    return DateTime.timestamp().difference(this);
  }

  Future<Duration> get timeLeft async {
    final timeAgo = await this.timeAgo;
    return ttl - timeAgo;
  }

  Future<bool> get isCacheUpToDate async {
    final timeAgo = await this.timeAgo;
    return timeAgo < ttl;
  }
}
