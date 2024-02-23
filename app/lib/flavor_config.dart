enum Flavor { dev, uat, production }

class FlavorValues {
  FlavorValues(
      {required this.baseUrl,
      required this.useAnalytics,
      required this.logsResponse});
  final String baseUrl;
  final bool useAnalytics;
  final bool logsResponse;
}

class FlavorConfig {
  late final Flavor flavor;
  late final FlavorValues values;

  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _inst.flavor = flavor;
    _inst.values = values;
    return _inst;
  }

  FlavorConfig._internal();
  static final FlavorConfig _inst = FlavorConfig._internal();

  static bool isProduction() => _inst.flavor == Flavor.production;
  static bool isDevelopment() => _inst.flavor == Flavor.dev;
  static bool isUAT() => _inst.flavor == Flavor.uat;
  static bool useAnalytics() => _inst.values.useAnalytics;
  static String baseUrl() => _inst.values.baseUrl;
  static bool logsResponse() => _inst.values.logsResponse;

  static String envFile() {
    switch (_inst.flavor) {
      case Flavor.dev:
        return ".dev.env";
      case Flavor.uat:
        return ".uat.env";
      case Flavor.production:
        return ".prod.env";
    }
  }
}
