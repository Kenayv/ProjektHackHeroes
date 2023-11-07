// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project_hack_heroes/theme.dart';
import 'package:project_hack_heroes/user.dart';
import 'package:project_hack_heroes/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Container(
          color:usertheme.Primarybgcolor,
          child: Column(
          children: [
            Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "STUDI",
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: usertheme.TextColor),
                  ),
                ],
              ),
            ),
            // Pozostała zawartość
            Container(
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text("Streak: 6 Dni🔥", style: TextStyle(fontSize: 18,color: usertheme.TextColor)),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text("Łącznie nauki: 3h 57m", style: TextStyle(fontSize: 18, color: usertheme.TextColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Zostało dziś jeszcze: ",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: usertheme.TextColor),
                    ),
                    Text(
                      "57% ",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: usertheme.TextColor),
                    ),
                    Text(
                      "zadań.",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: usertheme.TextColor),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: 360,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text("Zadanie 1", style: TextStyle(fontSize: 20, color: usertheme.TextColor)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: 360,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text("Zadanie 2", style: TextStyle(fontSize: 20, color: usertheme.TextColor)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: 360,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        "Zadanie 3",
                        style: TextStyle(fontSize: 20, color: usertheme.TextColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dzisiaj to już na tyle!",
                    style: TextStyle(fontSize: 20, color: usertheme.TextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
