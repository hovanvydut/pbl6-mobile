enum Flavor { development, production }

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    return _instance ??= FlavorConfig._(
      flavor: flavor,
      values: values,
    );
  }
  FlavorConfig._({required this.flavor, required this.values});

  final Flavor flavor;
  final FlavorValues values;

  static FlavorConfig? _instance;

  static FlavorConfig get instance => _instance!;

  static bool isProduction() => _instance!.flavor == Flavor.production;

  static bool isDevelopment() => _instance!.flavor == Flavor.development;
}

class FlavorValues {
  FlavorValues({
    required this.baseUrl,
    this.version = '',
    this.buildNumber = '',
  });
  final String baseUrl;
  final String version;
  final String buildNumber;

  FlavorValues copyWith({
    String? baseUrl,
    String? version,
    String? buildNumber,
  }) {
    return FlavorValues(
      baseUrl: baseUrl ?? this.baseUrl,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }
}
