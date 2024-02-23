import '../core/db/database_manager.dart';
import 'injector.dart';

class DatabaseModule {
  DatabaseModule._();

  static void init() async {
    final injector = Injector.instance;
    injector.registerSingletonAsync<AppDatabaseManager>(() async {
      final AppDatabaseManager databaseManager = AppDatabaseManager();
      await databaseManager.createDatabase();
      return databaseManager;
    });
  }
}
