import 'package:flutter/material.dart';

//FIXME: stąd da się wrócić na poprzedni ekran używając <- (strzałki w lewo na telefonie)
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text('Konto', style: TextStyle(fontSize: 32)),
          ),
        ],
      ),
    );
  }
}
