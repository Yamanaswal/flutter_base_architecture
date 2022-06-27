import 'package:flutter_base_architecture/utils/log.dart';
import 'package:hive_flutter/adapters.dart';

const _TAG = "Database";

class Database {

  Database() {
    _init();
  }

  /*
  Initialize Database - Hive.
  * */
  void _init() async {
    await Hive.initFlutter();
  }


  /*
  Create A New Box (means Table is created or already opened)
  * */
  Future<bool> createBox<E>(String tableName, {bool crashRecovery = true, String path = ""}) async {

    var box = await Hive.openBox<E>(
      tableName,
      crashRecovery: crashRecovery,
      path: path == "" ? null : path,
    );

    if(box.isOpen){
      console(_TAG, "Box of ${box.name} is Currently Open Status is: ${box.isOpen}");
      return true;
    }

    return false;
  }


  /*
  Get the Box (Table).
  * */
  Future<Box<E>> getBox<E>(String tableName) async {
    var box = Hive.box<E>(tableName);
    console(_TAG, "Box of ${box.name} is Currently Open Status is: ${box.isOpen}");

    if(box.isOpen){
      return box;
    }

    throw Exception("$tableName is not opened");
  }


  /*
  Close the Box (Table).
  * */
  Future<bool> closeBox<E>(String tableName) async {
    var box = Hive.box<E>(tableName);
    box.close();
    return !box.isOpen;
  }

  /*

  * */
  Future<E?> readBox<E>(String tableName,String key,E? defaultValue) async {
    var box = Hive.box<E>(tableName);
    return box.get(key,defaultValue: defaultValue);
  }


}
