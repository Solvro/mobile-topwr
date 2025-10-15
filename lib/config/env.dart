import "package:envied/envied.dart";

part "env.g.dart";

@Envied(path: ".env", obfuscate: true, useConstantCase: true, requireEnvFile: true)
abstract class Env {
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
  @EnviedField()
  static final String bugsinkDsn = _Env.bugsinkDsn;
  @EnviedField()
  static final String umamiUrl = _Env.umamiUrl;
  @EnviedField()
  static final String umamiId = _Env.umamiId;
  @EnviedField()
  static final String mainRestApiUrl = _Env.mainRestApiUrl;
  @EnviedField()
  static final String radioLuzStreamUrl = _Env.radioLuzStreamUrl;
  @EnviedField()
  static final String radioLuzApiUrl = _Env.radioLuzApiUrl;
}
