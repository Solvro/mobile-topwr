import '../../utils/timestamp.dart';
import '../../config/ttl_config.dart';

class TimestampTtl extends Timestamp {
  TimestampTtl.nil(this.key) : super.nil();
  TimestampTtl.from(DateTime? ts, this.key) : super.from(ts);
  TimestampTtl.tryParse(String? formattedString, this.key)
      : super.tryParse(formattedString);

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
