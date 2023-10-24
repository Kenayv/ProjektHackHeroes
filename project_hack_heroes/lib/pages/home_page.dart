import 'package:flutter/material.dart';

//FIXME: stąd da się wrócić na poprzedni ekran używając <- (strzałki w lewo na telefonie)
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('Home Page', style: TextStyle(fontSize: 32)),
          ),
        ],
      ),
    );
  }
}
