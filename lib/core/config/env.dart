class EnvironmentConfig {
  // ignore: constant_identifier_names
  static const BASE_URL = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://numbersapi.com',
  );
}
