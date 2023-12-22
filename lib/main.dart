import 'package:flutter/gestures.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await currentUser.initUser();
  await noController.initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});




  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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





  PageController _pageController = PageController(initialPage: 2, viewportFraction: 1.0,keepPage: true);
  int _selectedIndex = 2;
 
  String currentPageTitle = 'Home';
  Color appbarcolor=Colors.blue;

  int desiredpage=0;

  Color checkccolor(int selected){

    switch(selected+1){

      case 1: return usertheme.page1; break;
      case 2: return usertheme.page2; break;
      case 3: return usertheme.page3; break;
      case 4: return usertheme.page4; break;
      case 5: return usertheme.page5; break;

    }
    return usertheme.colorWhite;

  }


  void changeappbarcolor(int currentpage,int targetpage){

    if(currentpage==targetpage){
      appbarcolor=checkccolor(targetpage);
    }


  }


  Widget studeeNavBar() {
    return BottomNavigationBar(

      type: BottomNavigationBarType.shifting,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.add_chart_sharp),
          label: 'To-Do',
          backgroundColor: appbarcolor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: 'Fiszki',
          backgroundColor: appbarcolor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: appbarcolor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: 'Medale',
          backgroundColor: appbarcolor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Konto',
          backgroundColor: appbarcolor,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: usertheme.colorWhite,
      backgroundColor: appbarcolor,

      onTap: (int index) {
        if (mounted) {
          setState(() {

            
            int page=_pageController.page!.round();

            desiredpage=index;
            appbarcolor=checkccolor(index);
            
            _selectedIndex = index;
            currentPageTitle = screenTitles[index];
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );



          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: usertheme.studeeAppBar(currentPageTitle),
      body: PageView.builder(
        key: const PageStorageKey<String>('TodoPage'),
        controller: _pageController,
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return screens[index];
        },
        onPageChanged: (index) {
          if (mounted) {
            setState(() {
              int page=_pageController.page!.round();
              //appbarcolor=checkccolor(index); //tu jest zle
               _selectedIndex = index;

              changeappbarcolor(page, desiredpage);

              currentPageTitle = screenTitles[index];

            });
          }

        },


        pageSnapping: true,
        physics: ClampingScrollPhysics(),
      ),

      bottomNavigationBar: studeeNavBar(),





    );





  }


  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {

        int currentPage = _pageController.page!.round();
        if (currentPage != desiredpage) {
          setState(() {
            changeappbarcolor(currentPage, desiredpage);
          });
        }
      }
    );

  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }
}
