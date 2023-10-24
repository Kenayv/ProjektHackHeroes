// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'beta_pop_up.dart';
import 'studi_bottom_navigation_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const BetaPopUpPage(title: 'Flutter Demo Home Page'),
    );
  }
}

//FIXME: stąd da się wrócić na poprzedni ekran używając <- (strzałki w lewo na telefonie)
//FIXME: totalnie nie wiem, czy taki format Page i _state jest poprawny. trzeba to sprawdzić kiedyś
class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          Text('Dalej', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          StudiBottomNavigationBar()
        ],
      ),
    );
  }
}

void changePageTo(BuildContext context, int index) {
  switch (index) {
    case 0:
    case 2:
    case 3:
    case 4:
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenuPage()),
      );
    default:
      throw Exception("Page $index doesn't exist!");
  }
}
