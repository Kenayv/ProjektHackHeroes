import 'package:flutter/material.dart';

//FIXME: stąd da się wrócić na poprzedni ekran używając <- (strzałki w lewo na telefonie)
class FooPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('Foo', style: TextStyle(fontSize: 32)),
          ),
        ],
      ),
    );
  }
}