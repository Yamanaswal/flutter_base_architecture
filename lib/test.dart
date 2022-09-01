import 'package:flutter/widgets.dart';
import 'package:flutter_base_architecture/models/database/database_models.dart';
import 'package:flutter_base_architecture/models/network/models/posts/post.dart';
import 'package:library_store/database/database_manager.dart';
import 'package:library_store/library_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var test = String.fromEnvironment("SOME_VAR");
  Log.e("SOME_VAR", test);

  var db = DatabaseManager();
  await DatabaseModels().createTables(db);

  var post = Post();
  post.title = "Hello";
  post.id = 200;
  db.database.insert("Test1", post.toJson());
  db.database.insert("Test1", post.toJson());
  db.database.insert("Test1", post.toJson());
  db.database.insert("Test1", post.toJson());
  db.database.insert("Test1", post.toJson());
  db.database.insert("Test1", post.toJson());
  db.database.rawQuery("Select * From Test1");

  db.clearTable(tableName: "Test1");
  db.database.insert("Test1", post.toJson());
  db.database.insert("Test1", post.toJson());

  var tableData = await db.getTableData(tableName: "Test1");
  Log.e("TEST1: (1) --> ", tableData);

  db.insertOne(tableMap: post.toJson(), tableName: "Test1");
  db.updateMany(tableName: "Test1", tableMap: post.toJson());

  var post2 = Post();
  post2.body = "Update One Worked.";
  db.updateOne(tableName: "Test1", tableMap: post2.toJson(), whereString: "userId = 2");
  var data = await db.getTableData(tableName: "Test1");
  Log.e("TEST1: (2) --> ", data);

  var socketManager = SocketManager();
  socketManager.init();

  socketManager.emit("event", "data from event.");

}
