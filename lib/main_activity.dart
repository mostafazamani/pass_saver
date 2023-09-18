import 'package:flutter/material.dart';
import 'package:pass_saver/item_model.dart';
import 'package:pass_saver/list_adapter.dart';
import 'package:pass_saver/my_data_base.dart';
import 'dart:async';


class MainActivity extends StatefulWidget {
  MainActivity({Key? key, required this.s}) : super(key: key);
  final MyDatabase s;

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int counter = 20;
  Future<List<ItemModel>>? myFuture;

  @override
  void initState() {
    myFuture = widget.s.getItem();
    widget.s.initDb();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void update(int x) {
    setState(() {
      myFuture = widget.s.getItem();
    });
  }

  void delete() {
    setState(() {
      myFuture = widget.s.getItem();
    });

  }

  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myFuture = widget.s.getItem();
    return Scaffold(
      body:FutureBuilder<List<ItemModel>>(
        future: myFuture,
        builder: (context, snapshot) {
          print("re build");
          if (snapshot.hasData) {
            List<ItemModel> list = snapshot.requireData;
            if (snapshot.requireData.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ListAdapter(
                        number: index,
                        delete: delete,
                        db: widget.s,
                        username: snapshot.requireData[index].username,
                        name: snapshot.requireData[index].name,
                        password: snapshot.requireData[index].pass);
                  },
                  itemCount: snapshot.requireData.length,
                ),
              );
            } else {
              return const Center(
                child:  SizedBox(
                  child: Text("No data"),
                ),
              );
            }
          } else {
            return const Center(
              child:  CircularProgressIndicator(
                backgroundColor: Colors.green,
                strokeWidth: 2,
              ),
            );
          }
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
            barrierLabel: "Label",
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: const Duration(milliseconds: 400),
            context: context,
            pageBuilder: (context, anim1, anim2) {
              return Dialog(
                  update: update,
                  s: widget.s,
                  name: name,
                  username: username,
                  password: password);
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                    .animate(anim1),
                child: child,
              );
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  String getpass(String p) {
    String? pass = '.';
    for (int x = 0; x < p.length - 1; x++) {
      pass = '$pass.';
    }
    return pass!;
  }
}

class Dialog extends StatefulWidget {
  TextEditingController username;
  TextEditingController name;
  TextEditingController password;
  final MyDatabase s;
  final Function update;

  Dialog(
      {Key? key,
      required this.update,
      required this.s,
      required this.name,
      required this.username,
      required this.password})
      : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> with TickerProviderStateMixin {
  // AnimationController? controller;
  // Animation<double>? scaleAnimation;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller =
    //     AnimationController(vsync: this, duration: Duration(seconds: 1));
    // scaleAnimation =
    //     CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);
    // controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save password'),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('name : '),
            ),
            TextField(
              controller: widget.name,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "name",
                  hintText: "Enter Name"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('UserName : '),
            ),
            TextField(
              controller: widget.username,
              obscureText: false, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "UserName",
                  hintText: "Enter your Username"),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('PassWord : '),
            ),
            TextField(
              controller: widget.password,
              maxLength: 10,
              obscureText: true, //for password
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //InputBorder.none,
                  labelText: "PassWord",
                  hintText: "Enter your Password"),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              widget.name.clear();
              widget.password.clear();
              widget.username.clear();
            });
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            var item = ItemModel(
                username: widget.username.text,
                name: widget.name.text,
                pass: widget.password.text);

            widget.s.inserItem(item);
            widget.update(1);

            setState(() {
              widget.name.clear();
              widget.password.clear();
              widget.username.clear();
            });
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
