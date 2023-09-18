import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'item_model.dart';

class MyDatabase {
  Future<Database> initDb() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'item_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, username TEXT, pass TEXT)",
        );
      },
      version: 3,
    );
    return db;
  }

  Future<void> inserItem(ItemModel itemModel) async {
    Database db = await initDb();
    int i = await db.insert('items', itemModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(i.toString());
  }

  Future<List<ItemModel>> getItem() async {
    Database db = await initDb();

    List<Map<String, dynamic>> map = await db.query('items');

    return List.generate(map.length, (index) {
      return ItemModel(
          username: map[index]['username'],
          name: map[index]['name'],
          pass: map[index]['pass']);
    });
  }

  Future<int> search(String name)async{
    Database db = await initDb();

   List<Map<String,dynamic>> x = await db.query('items',where: "name = ? " , whereArgs: [name],columns: ['id']);

   int id = x[0]['id'];
   print(id.toString());
   return id;

  }

  Future<void> delete(String name) async {
    Database db = await initDb();
    List<Map<String,dynamic>> x = await db.query('items',where: "name = ? " , whereArgs: [name],columns: ['id']);

    int id = x[0]['id'];
    print(id.toString());

    int s =await db.delete('items', where: "id = ? ", whereArgs: [id]);
    print(s.toString());

  }
}
