import 'package:flutter_base_architecture/models/database/database_manager.dart';

class DatabaseModels {

  ///
  /// Table Models.
  /// */
  Future<void> createTables(DatabaseManager databaseManager) async {
    await databaseManager.init();

    databaseManager.create(
      tableName: "Test1",
      tableColumns:
          "userId INTEGER PRIMARY KEY, id INTEGER, title TEXT,body TEXT",
    );

  }
}



