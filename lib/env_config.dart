enum Environment { dev, prod }

abstract class AppEnvironment {
  static late String baseUrl;
  static late String environmentName;

  static late Environment _environment;
  static Environment get environment => _environment;

  static void setUpEnv(Environment environment) {
    _environment = environment;

    switch (_environment) {
      case Environment.dev:
        baseUrl = "http://192.168.7.12:8000";
        environmentName = "DEV";
        break;

      case Environment.prod:
        baseUrl = "http://192.168.7.9:8000";
        environmentName = "PROD";
        break;
    }
  }
}
