// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
                  Text("STUDI", style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.black87)),
                ],
              ),
            ),
            // Pozostała zawartoś
            Container(
              child: SizedBox(
                height: 40,
                child: Container(
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
                          child: Text("Godzin nauki: 0h 57 min", style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    "Do Zrobienia:",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      width: 360,
                      height: 200,
                      color: Colors.red,
                      child: Center(
                        child: Text("Blok 1", style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      width: 360,
                      height: 200,
                      color: Colors.orange,
                      child: Center(
                        child: Text("Blok 2", style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      width: 360,
                      height: 200,
                      color: Colors.blue,
                      child: Center(
                        child: Text("Blok 3", style: TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    ),
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
