import "package:envied/envied.dart";

part "env.g.dart";

abstract class ApiBaseConfig {
  static const hiveCacheBoxName = "hiveCacheBoxForDirectusGraphQL";
  static const authHeaderPrefix = "Bearer ";
  static const ttlPrefsPrefix = "TTL_CACHE_TIMESTAMP_PREFIX_";
}

@Envied(path: ".env", obfuscate: true, useConstantCase: true, requireEnvFile: true)
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
  @EnviedField()
  static final String digitalGuideUrl = _Env.digitalGuideUrl;
  @EnviedField()
  static final String digitalGuideAuthorizationToken = _Env.digitalGuideAuthorizationToken;
  @EnviedField()
  static final String digitalGuideAddonsUrl = _Env.digitalGuideAddonsUrl;
  @EnviedField()
  static final String parkingApiUrl = _Env.parkingApiUrl;
  @EnviedField()
  static final String translateApiUrl = _Env.translateApiUrl;
  @EnviedField()
  static final String translateApiToken = _Env.translateApiToken;
}
