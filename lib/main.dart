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
  WidgetsFlutterBinding.ensureInitialized();
  await currentUser.initUser();
  await noController.initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  //required for async notifications
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //WARNING: onActionReceivedMethod: NotificationController.on MOVED TO notification_controller.dart. If something goes wrong, listeners should be brought back into initState()
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studee - Learn. The simple way.',
      home: FutureBuilder<bool>(
        future: currentUser.hasSeenIntroduction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final hasSeenIntroduction = snapshot.data;
            if (hasSeenIntroduction == false) {
              return const IntroductionScreens();
            } else {
              return const BetaPopUpPage();
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
  final screens = [
    TodoPage(),
    const FlashCardsPage(),
    const HomePage(),
    const AchievementPage(),
    const AccountPage(),
  ];

  final screenTitles = [
    'To-Do',
    'Fiszki',
    'Home',
    'Medale',
    'Konto',
  ];

  int _selectedIndex = 2;
  String currentPageTitle = 'Home';

  //FIXME: Either this function should be put in theme.dart or the appbar should be moved here.
  Widget studeeNavBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.add_chart_sharp),
          label: screenTitles[0],
          backgroundColor: usertheme.page1,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: screenTitles[1],
          backgroundColor: usertheme.page2,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: screenTitles[2],
          backgroundColor: usertheme.page3,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: screenTitles[3],
          backgroundColor: usertheme.page4,
        ),
        BottomNavigationBarItem(
            icon: const Icon(Icons.settings), label: screenTitles[4], backgroundColor: usertheme.page5),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: usertheme.colorWhite,
      onTap: (int index) => setState(
        () {
          _selectedIndex = index;
          currentPageTitle = screenTitles[index];
        },
      ),
    );
  }

  //  -   -   -   -   -   -   -  APP SCREEN  -   -   -   -   -   -   -   -   -   -

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: usertheme.studeeAppBar(currentPageTitle),
      body: screens[_selectedIndex],
      bottomNavigationBar: studeeNavBar(),
    );
  }
}
