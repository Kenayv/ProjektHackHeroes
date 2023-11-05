// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_hack_heroes/pages/achievement_page.dart';
import 'beta_pop_up.dart';
import 'pages/account_page.dart';
import 'pages/todo_page.dart';
import 'pages/home_page.dart';
import 'pages/flash_cards_page.dart';
import 'pages/introduction_screen.dart';
import 'user.dart';
//  -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -








void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studi - Hack Heroes Projekt',
      home: FutureBuilder<bool>(                        //od tąd
        future: currentUser.getHasSeenIntroduction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');       //sprawdza czy introduction
          } else {                                         //bylo juz raz wyswietlane
            //final hasSeenIntroduction = snapshot.data;
            final hasSeenIntroduction=false;
            if (hasSeenIntroduction == false) {
              return const IntroductionScreens();
            } else if (hasSeenIntroduction == true) {
              return BetaPopUpPage();
            } else {
              // Return a default widget here, e.g., an empty Container.
              return Container();                   //do tąd
            }
          }
        },
      ),
    );
  }
}

//  -   -   -   -   -   -   ↓ Main page ↓   -   -   -   -   -   -   -

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 2;

  final screens = [
    TodoPage(),
    FlashCardsPage(),
    HomePage(),
    AchievementPage(),
    AccountPage(),
    IntroductionScreens(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromRGBO(0, 0, 0, 0.3), // barely visible black shadow - looks like a line
        backgroundColor: Color.fromRGBO(250, 250, 250, 1), //bar should be background color.
        automaticallyImplyLeading: false,
        actions: <Widget>[],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart_sharp),
            label: 'To-Do',
            backgroundColor: Color.fromARGB(255, 236, 43, 43),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Fiszki',
            backgroundColor: Color.fromRGBO(250, 146, 26, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 22, 170, 34),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Medale',
            backgroundColor: Color.fromARGB(255, 35, 153, 231),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Konto',
            backgroundColor: Color.fromRGBO(128, 128, 128, 1),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(128, 224, 62, 1),
        onTap: (int index) => setState(
          () {
            _selectedIndex = index;
          },
        ),
      ),
    );
  }
}
