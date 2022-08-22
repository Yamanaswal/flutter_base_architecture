import 'dart:async';
import 'package:flutter_base_architecture/models/network/models/posts/post.dart';
import 'package:flutter_base_architecture/utils/log.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const _TAG = "Database";

class DatabaseManager {

  // Singleton Class Object
  static final DatabaseManager _singleton = DatabaseManager._internal();

  factory DatabaseManager() {
    return _singleton;
  }

  DatabaseManager._internal();

  late Database _database;

  Database get database => _database;

  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    console("getDatabasesPath: ", databasesPath);
    String path = join(databasesPath, 'demo.db');
    console("db path: ", path);

    _database = await openDatabase(path,
        version: 1,
        onUpgrade: (db, version, value) async {},
        onConfigure: (db) {},
        onDowngrade: (db, version, value) async {},
        readOnly: false,
        singleInstance: true);
  }

  Future<void> create({required String tableName, required String tableColumns}) async {
    try {
      if(_database.isOpen){
        await _database.execute('CREATE TABLE $tableName ($tableColumns)');
      }
    } catch (ex) {
      console("create", ex.toString());
    }
  }

  Future<bool> insertOne({required String tableName, required Map<String,dynamic> tableMap}) async {
    try {
      if(!_database.isOpen){
        return false;
      }

      var value = await _database.insert(tableName, tableMap, conflictAlgorithm: ConflictAlgorithm.replace);
      console("insertOne Value: -> ", value);
      return true;

    } catch (ex) {
      console("insertOne", ex.toString());
    }
    return false;
  }

  Future<bool> updateMany({required String tableName, required Map<String,dynamic> tableMap}) async {
    try {
      if(!_database.isOpen){
        return false;
      }

      var queryString = getQueryFromMap(tableMap);

      await _database.rawQuery("UPDATE $tableName SET $queryString ");
      return true;

    } catch (ex) {
      console("updateMany", ex.toString());
    }
    return false;
  }


  Future<bool> updateOne({required String tableName, required Map<String,dynamic> tableMap , required String whereString}) async {
    try {
      if(!_database.isOpen){
        return false;
      }

      var queryString = getQueryFromMap(tableMap);

      await _database.rawQuery("UPDATE $tableName SET $queryString Where $whereString");
      return true;

    } catch (ex) {
      console("updateMany", ex.toString());
    }
    return false;
  }


  Future<List<Map<String, Object?>>> getTableData({required String tableName}) async {
    try {
      if(!_database.isOpen){
        return [];
      }

      return await _database.rawQuery("Select * From $tableName");
    } catch (ex) {
      console("getTableData Exception: ", ex.toString());
    }
    return [];
  }



  Future<void> delete({required String tableName, required String whereKey,required String whereValue}) async {
    try {
      if(_database.isOpen){
        await _database.rawDelete("DELETE FROM $tableName WHERE $whereKey = $whereValue");
      }
    } catch (ex) {
      console("delete", ex.toString());
    }
  }

  Future<void> dropTable({required String tableName }) async {
    try {
      if(_database.isOpen){
        await _database.rawQuery('DROP TABLE $tableName');
      }
    } catch (ex) {
      console("dropTable Exception: ", ex.toString());
    }
  }

  Future<int> clearTable({required String tableName}) async {
    try {
      if(_database.isOpen){
        return await _database.rawDelete("DELETE FROM $tableName");
      }
    } catch (ex) {
      console("clearTable Exception: ", ex.toString());
    }
    return 0;
  }


  Future<bool> closeDatabase() async {
    try {
      if(_database.isOpen){
        await _database.close();
        return true;
      }
    } catch (ex) {
      console("closeDatabase Exception: ", ex.toString());
    }
    return false;
  }


  String getQueryFromMap(Map<String, dynamic> tableMap){

    String query = "";

    tableMap.forEach((key, value) {
      console("key:", key);
      console("value:", value.toString());
      console("runtimeType:",  value.runtimeType);

      if(value.runtimeType != Null){
        query += key + " = ";
      }

      if(value.runtimeType == String){
        query += "'$value'";
      }

      if(value.runtimeType == int){
        query += "$value";
      }

      if(value.runtimeType != Null){
        query += ",";
      }

    });

    console("query: ", query.replaceRange(query.length - 1, query.length, ""));
    return query.replaceRange(query.length - 1, query.length, "");
  }

}
