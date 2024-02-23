import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'flavor_config.dart';
import 'main.dart' as main_file;

void main() async {
  await dotenv.load(fileName: ".dev.env");
  FlavorConfig(
      flavor: Flavor.dev,
      values: FlavorValues(
          baseUrl: dotenv.env['BASEURL']!,
          useAnalytics: false,
          logsResponse: true));
  main_file.main();
}
