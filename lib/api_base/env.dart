import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  path: '.env',
  obfuscate: true,
  useConstantCase: true,
  requireEnvFile: true,
)
abstract class Env {
  @EnviedField()
  static final String apiUrl = _Env.apiUrl;
  @EnviedField()
  static final String apiKey = _Env.apiKey;
}
