import 'base_config.dart';
import 'dev_config.dart';
import 'prod_config.dart';
import 'staging_config.dart';

class Environment {
  factory Environment() => _instance;
  Environment._internal();

  static final Environment _instance = Environment._internal();
  static const String dev = 'DEV';
  static const String staging = 'STAGING';
  static const String prod = 'PROD';

  late BaseConfig config;

  void initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.dev:
        return DevConfig();
      case Environment.staging:
        return StagingConfig();
      case Environment.prod:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
