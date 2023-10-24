import 'package:flutter/material.dart';
import 'main.dart';

class StudiBottomNavigationBar extends StatefulWidget {
  const StudiBottomNavigationBar({super.key});

  @override
  State<StudiBottomNavigationBar> createState() => _StudiBottomNavigationBarState();
}

class _StudiBottomNavigationBarState extends State<StudiBottomNavigationBar> {
  int _selectedIndex = 0;

  //FIXME: po wywołaniu funkcji tworzy się nowy state i zdefaulta w NavBarze wybierany jest TO_DO, nie ważne co się
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    changePageTo(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart_sharp),
            label: 'To Do',
            backgroundColor: Color.fromARGB(255, 236, 43, 43),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Fiszki',
            backgroundColor: Color.fromRGBO(250, 146, 26, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
            backgroundColor: Color.fromARGB(255, 22, 170, 34),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Memorizz',
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
        onTap: _onItemTapped,
      ),
    );
  }
}
