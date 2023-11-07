// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:project_hack_heroes/pages/achievement_page.dart';
import 'package:project_hack_heroes/user.dart';
import 'beta_pop_up.dart';
import 'pages/account_page.dart';
import 'pages/todo_page.dart';
import 'pages/home_page.dart';
import 'pages/flash_cards_page.dart';
import 'notification_controller.dart';
import 'pages/introduction_screen.dart';
import 'theme.dart';

//  -   -   -   -   -   -   -   -    -   -   -   -   -   -   -   -   -

void main() async {
  await initAll();
  runApp(const MyApp());
}

//  -   -   -   -   -   -   -   -    -   -   -   -   -   -   -   -   -

Future<void> initAll() async {
  WidgetsFlutterBinding.ensureInitialized();
  await currentUser.initUser();
  await noController.initNotifications();
}

//  -   -   -   -   -   -   -   -    -   -   -   -   -   -   -   -   -

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //required for async notifications
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

//  -   -   -   -   -   -   -   -    -   -   -   -   -   -   -   -   -

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    //WARNING: onActionReceivedMethod: NotificationController.on MOVED TO notification_controller.dart. If something goes wrong, listenersshould be brought back there
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studi - Hack Heroes Projekt',
      home: FutureBuilder<bool>(
        //od tąd
        future: currentUser.getHasSeenIntroduction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); //sprawdza czy introduction
          } else {
            //bylo juz raz wyswietlane
            final hasSeenIntroduction = snapshot.data;

            if (hasSeenIntroduction == false) {
              return const IntroductionScreens();
            } else if (hasSeenIntroduction == true) {
              return BetaPopUpPage();
            } else {
              // Return a default widget here, e.g., an empty Container.
              return Container(); //do tąd
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
  String currentPageTitle = 'Home';

  final screens = [
    TodoPage(),
    FlashCardsPage(),
    HomePage(),
    AchievementPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (currentUser.getTheme() == "White") {
      usertheme = whitetheme;
    } else {
      usertheme = blacktheme;
    }
    return Scaffold(
      appBar: usertheme.getAppBar(currentPageTitle),
      body: screens[_selectedIndex],
      bottomNavigationBar: studeeNavBar(),
    );
  }

  BottomNavigationBar studeeNavBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add_chart_sharp),
          label: 'To-Do',
          backgroundColor: usertheme.Page1,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Fiszki',
          backgroundColor: usertheme.Page2,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: usertheme.Page3,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Medale',
          backgroundColor: usertheme.Page4,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Konto',
          backgroundColor: Color.fromRGBO(128, 128, 128, 1),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color.fromARGB(255, 255, 255, 255),
      onTap: (int index) => setState(
        () {
          _selectedIndex = index;
          currentPageTitle = _getPageTitle(index);
        },
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'To-Do';
      case 1:
        return 'Fiszki';
      case 2:
        return 'Home';
      case 3:
        return 'Medale';
      case 4:
        return 'Konto';
      default:
        return 'Home';
    }
  }
}
