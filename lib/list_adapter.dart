import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pass_saver/my_data_base.dart';

class ListAdapter extends StatefulWidget {
  const ListAdapter(
      {Key? key,
      required this.delete,
      required this.db,
      required this.name,
      required this.username,
      required this.password,
      required this.number})
      : super(key: key);

  final String name;
  final String username;
  final String password;
  final MyDatabase db;
  final Function delete;
  final int number;

  @override
  _ListAdapterState createState() => _ListAdapterState();
}

class _ListAdapterState extends State<ListAdapter>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? cr;
  Orientation? orientation;
  Animation<Offset>? tween;
  bool? x;

  @override
  void initState() {
    x = true;
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    cr = CurvedAnimation(parent: controller!, curve: Curves.easeInBack);
    tween =
        Tween(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(cr!);

    controller!.addListener(() {
      if (tween!.isCompleted && controller!.isCompleted && cr!.isCompleted) {
        // widget.delete(widget.number-1);
        setState(() {
          x = false;
          widget.delete();
        });
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    if (x!) {
      return AnimatedBuilder(
        builder: (BuildContext context, Widget? child) {
          return SlideTransition(
            position: tween!,
            child: child,
          );
        },
        animation: controller!,
        child: // Figma Flutter Generator PriceWidget - FRAME
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color.fromRGBO(120, 180, 250, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              widget.username,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(238, 241, 244, 1),
                                  fontFamily: 'Mulish',
                                  fontSize: 14,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.2142857142857142),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.password,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontFamily: 'Mulish',
                                  fontSize: 20,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.15),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        child: Text(
                          widget.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              letterSpacing:
                                  0 /*percentages not used in flutter. defaulting to zero*/,
                              fontWeight: FontWeight.normal,
                              height: 1.15),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      widget.db.delete(widget.name);
                      controller!.forward();
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  String getpass(String p) {
    String? pass = '.';
    for (int x = 0; x < p.length - 1; x++) {
      pass = '$pass.';
    }
    return pass!;
  }
}
