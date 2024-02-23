import 'package:get_it/get_it.dart';
import 'bloc_module.dart';
import 'data_source_module.dart';
import 'database_module.dart';
import 'repository_module.dart';
import 'rest_client_module.dart';
import 'service_module.dart';

class Injector {
  static GetIt instance = GetIt.instance;
  Injector._();

  static void init() async {
    ServiceModule.init();
    DatabaseModule.init();
    DataSourceModule.init();
    RestClientModule.init();
    RepositoryModule.init();
    BlocModule.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
