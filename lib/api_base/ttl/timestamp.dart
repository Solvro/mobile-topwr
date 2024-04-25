import 'ttl_config.dart';

class Timestamp extends DateTime {
  Timestamp.nil(this.key) : super(0);

  Timestamp.from(
    DateTime? ts,
    this.key,
  ) : super.fromMillisecondsSinceEpoch(ts?.millisecondsSinceEpoch ?? 0);

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
