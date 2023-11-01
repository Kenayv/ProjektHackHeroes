// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "STUDI",
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.black87),
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
                        child: Text("Streak: 6 Dni🔥", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text("Łącznie nauki: 3h 57m", style: TextStyle(fontSize: 18)),
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
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "57% ",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
                    ),
                    Text(
                      "zadań.",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                      child: Text("Zadanie 1", style: TextStyle(fontSize: 20, color: Colors.white)),
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
                      child: Text("Zadanie 2", style: TextStyle(fontSize: 20, color: Colors.white)),
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
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
