import "package:envied/envied.dart";

part "env.g.dart";

abstract class ApiBaseConfig {
  static const hiveCacheBoxName = "hiveCacheBoxForDirectusGraphQL";
  static const authHeaderPrefix = "Bearer ";
  static const ttlPrefsPrefix = "TTL_CACHE_TIMESTAMP_PREFIX_";
}

@Envied(
  path: ".env",
  obfuscate: true,
  useConstantCase: true,
  requireEnvFile: true,
)
abstract class Env {
  @EnviedField()
  static final String apiUrl = _Env.apiUrl;
  @EnviedField()
  static final String assetsUrl = _Env.assetsUrl;
  @EnviedField()
  static final String iparkingUrl = _Env.iparkingUrl;
  @EnviedField()
  static final String wiredashId = _Env.wiredashId;
  @EnviedField()
  static final String wiredashSecret = _Env.wiredashSecret;
  @EnviedField()
  static final String sksUrl = _Env.sksUrl;
}
