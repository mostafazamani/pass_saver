import 'package:flutter/material.dart';
import 'package:pass_saver/finger_print.dart';
import 'package:pass_saver/main_activity.dart';
import 'package:pass_saver/my_data_base.dart';


void main() {
  final MyDatabase s = MyDatabase();
  runApp(MyApp(s: s,));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.s}) : super(key: key);
  final MyDatabase s;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Save password',
      home: MyHomePage(title: 'Save passwords', s: s,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.s})
      : super(key: key);
  final String title;
  final MyDatabase s;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MyApp1(),
      // MainActivity(s:widget.s), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

// Future<void> inserItem(ItemModel itemModel) async {
//   Future<Database> database = openDatabase(
//     join(await getDatabasesPath(), 'item_database.db'),
//     onCreate: (db, version) {
//       return db.execute(
//         "CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
//       );
//     },
//     version: 1,
//   );
//
//   final Database db = await database;
//
//   int i = await db.insert('items', itemModel.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace);
// }
}
