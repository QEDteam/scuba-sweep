import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY', obfuscate: true)
  static final String openaiApiKey = _Env.openaiApiKey;
}