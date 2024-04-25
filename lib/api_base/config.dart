import 'package:envied/envied.dart';

part 'config.g.dart';

abstract class ApiBaseConfig {
  static const hiveCacheBoxName = "hiveCacheBoxForGraphQL";
  static const authHeaderPrefix = "Bearer ";
  static const ttlPrefsPrefix = "TTL_CACHE_TIMESTAMP_PREFX_";
}

@Envied(
  path: '.env',
  obfuscate: true,
  useConstantCase: true,
  requireEnvFile: true,
)
abstract class ApiBaseEnv {
  @EnviedField()
  static final String apiUrl = _ApiBaseEnv.apiUrl;
  @EnviedField()
  static final String apiKey = _ApiBaseEnv.apiKey;
}
