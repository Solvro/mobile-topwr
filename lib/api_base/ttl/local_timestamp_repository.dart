import 'package:graphql/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/timestamp.dart';
import '../config.dart';
import 'ttl_timestamp.dart';
import 'ttl_config.dart';

part "local_timestamp_repository.g.dart";

class LocalTimestampRepo {
  final TtlKey _key;
  final SharedPreferences _prefs;

  LocalTimestampRepo(this._key, this._prefs);

  String get _storeKey => "${ApiBaseConfig.ttlPrefsPrefix}$_key";

  Future<TimestampTtl> getTimestamp() async {
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

@riverpod
Future<LocalTimestampRepo> localTimestampRepo(
  LocalTimestampRepoRef ref,
  TtlKey key,
) async {
  final prefs = await SharedPreferences.getInstance();
  return LocalTimestampRepo(key, prefs);
}
