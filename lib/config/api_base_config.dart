import 'package:envied/envied.dart';

part 'api_base_config.g.dart';

abstract class ApiBaseConfig {
  static const hiveCacheBoxName = "hiveCacheBoxForDirectusGraphQL";
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
  static final String assetsUrl = _ApiBaseEnv.assetsUrl;
  @EnviedField()
  static final String iparkingUrl = _ApiBaseEnv.iparkingUrl;
}
