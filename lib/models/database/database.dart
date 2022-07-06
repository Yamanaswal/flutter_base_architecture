import 'dart:async';

import 'package:flutter_base_architecture/utils/log.dart';
import 'package:hive_flutter/hive_flutter.dart';

const _TAG = "Database";

class Database {

  // Singleton Class Object
  static final Database _singleton = Database._internal();

  factory Database()  {
    return _singleton;
  }

  Database._internal();

  /*
  Create A New Box (means Table is created or already opened)
  * */
  Future<bool> createBox<E>(String tableName, {bool crashRecovery = true, String path = ""}) async {

    try {
      var box = await Hive.openBox<E>(
        tableName,
        crashRecovery: crashRecovery,
        path: path == "" ? null : path,
      );

      if (box.isOpen) {
        console(_TAG, "Box of ${box.name} is Currently Open Status is: ${box.isOpen}");
        return true;
      }
    }catch(ex){
      console(_TAG + "Error: -> ", ex);
    }

    return false;
  }


  /*
  Get the Box (Table).
  * */
  Future<Box<E>> getBox<E>(String tableName) async {
    try{
      var box = Hive.box<E>(tableName);
      console(_TAG, "Box of ${box.name} is Currently Open Status is: ${box.isOpen}");

      if(box.isOpen){
        return box;
      }
    }catch(ex){
      console(_TAG + "Error: -> ", ex);
    }

    throw Exception("$tableName is not opened");
  }


  /*
  Close the Box (Table).
  * */
  Future<bool> closeBox<E>(String tableName) async {

    try{
      var box = Hive.box<E>(tableName);
      box.close();
      return !box.isOpen;
    }catch(ex){
      console(_TAG + "Error: -> ", ex);
      throw Exception(ex);
    }

  }

  /*
  Read From Box (Table) - From Index Value.
  * */
  E? readBoxIndex<E>(String tableName,int index) {

    try{
      var box = Hive.box<E>(tableName);
      return box.getAt(index);
    }catch(ex){
      console(_TAG + "Error: -> ", ex);
      throw Exception(ex);
    }

  }

  /*
  Write And Update Box (Table) from key and value.
  * */
  Future<void> writeBox<E>(String tableName,String key,E value) async {

    try{
      var box = Hive.box<E>(tableName);
      box.put(key,value);
    }catch(ex){
      console(_TAG + "Error: -> ", ex);
      throw Exception(ex);
    }

  }

 /*
  Delete Key-Value From Box (Table).
  * */
  Future<void> deleteBox<E>(String tableName,String key,E? value) async {

    try{
      var box = Hive.box<E>(tableName);
      await box.delete(key);
    }catch(ex){
      console(_TAG + "Error: -> ", ex);
      throw Exception(ex);
    }

  }


}
