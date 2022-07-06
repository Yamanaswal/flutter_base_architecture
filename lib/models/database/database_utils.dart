
import 'database.dart';
import 'database_const.dart';

Future<void> createTables() async {
  var database = Database();

  //Create Tables.
  await database.createBox<int>(tableName1);
}