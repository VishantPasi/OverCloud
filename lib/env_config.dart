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
        baseUrl = "API BASE URL";
        environmentName = "DEV";
        break;

      case Environment.prod:
        baseUrl = "API BASE URL";
        environmentName = "PROD";
        break;
    }
  }
}
