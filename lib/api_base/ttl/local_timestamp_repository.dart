import "package:graphql/client.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../config/api_base_config.dart";
import "../../config/ttl_config.dart";
import "../../utils/timestamp.dart";
import "ttl_timestamp.dart";

part "local_timestamp_repository.g.dart";

class LocalTimestampRepository {
  final TtlKey _key;
  final SharedPreferences _prefs;

  LocalTimestampRepository(this._key, this._prefs);

  String get _storeKey => "${ApiBaseConfig.ttlPrefsPrefix}$_key";

  TimestampTtl getTimestamp() {
    return TimestampTtl.tryParse(
      _prefs.getString(_storeKey),
      _key,
    );
  }

  Future<bool> saveTimestamp<T>(QueryResult<T> response) async {
    final stamp = Timestamp.from(response.timestamp).serializeUTC();
    return _prefs.setString(_storeKey, stamp);
  }
}

@Riverpod(keepAlive: true)
Future<SharedPreferences> _prefs(_PrefsRef ref) async {
  return SharedPreferences.getInstance();
}

@riverpod
Future<LocalTimestampRepository> localTimestampRepository(
  LocalTimestampRepositoryRef ref,
  TtlKey key,
) async {
  final prefs = await ref.watch(_prefsProvider.future);
  return LocalTimestampRepository(key, prefs);
}
