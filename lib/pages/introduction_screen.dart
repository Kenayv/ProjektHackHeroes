<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:project_hack_heroes/main.dart';
import 'package:introduction_screen/introduction_screen.dart';
=======
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_hack_heroes/main.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../beta_pop_up.dart';
>>>>>>> ostatnie_szlify
import 'package:project_hack_heroes/user.dart';
import 'time_picker_screen.dart';
/*
* plik zajmujacy sie wyswietlaniem introduction screena,
* ale tez obslugiwaniem czy uzytkownik go juz widzial czy nie
*
* wogole tez inne sprawy z tym introduyction screenem nie wiem
*
* */

<<<<<<< HEAD
//smieszne funkcje do smiesznych rzeczy

//intrdduction screen

=======

//smieszne funkcje do smiesznych rzeczy


//intrdduction screen





>>>>>>> ostatnie_szlify
class IntroductionScreens extends StatefulWidget {
  const IntroductionScreens({Key? key}) : super(key: key);

  @override
  _IntroductionScreensState createState() => _IntroductionScreensState();
}
<<<<<<< HEAD

=======
>>>>>>> ostatnie_szlify
class _IntroductionScreensState extends State<IntroductionScreens> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedTheme = 'White';
  TimeOfDay? selectedNotificationTime;
  String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        appBar: AppBar(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: IntroductionScreen(
              pages: [
                PageViewModel(
                  title: 'Welcome to Our App!',
                  body: 'This is a brief introduction to our app.',
                  decoration: getPageDecoration(),
                ),
                PageViewModel(
                  title: 'Meet the Creators',
                  body: 'This app is made by:',
=======
        appBar: AppBar(backgroundColor: Color.fromRGBO(248, 245, 250, 0.9999),shadowColor: Color.fromRGBO(201, 201, 201, 0.1),),
        body: Form(
          key: _formKey,

          child: IntroductionScreen(
              pages: [
                PageViewModel(
                  title: 'Aplikacja Studee!',
                  body: 'Co to jest?',
                  image: Image.asset("lib/assets/BaseLogoSwan.png"),
                  footer: Text("Jest to bardzo prosta aplikacja, stworzona w celu wspomagania nauki",textAlign: TextAlign.center,),
                  decoration: getPageDecoration(),
                ),
                PageViewModel(
                  title: 'Autorzy',
                  body: 'Aplikacja została zrobiona przez:',
>>>>>>> ostatnie_szlify
                  image: AspectRatio(
                    aspectRatio: 1100 / 876,
                    child: Image.asset('lib/assets/zdjecie1.png'),
                  ),
                  decoration: getPageDecoration(),
                  footer: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BulletPointListItem('Janek Grosicki'),
                      BulletPointListItem('Wiktor Gradzik'),
                      BulletPointListItem('Konrad Kaspirowicz'),
                      BulletPointListItem('Marcin Skrzypek'),
                    ],
                  ),
                ),
                PageViewModel(
<<<<<<< HEAD
                  title: 'Customize Your Experience',
                  body: 'Configure your app settings, theme, date, and username.',
=======
                  title: 'Skonfiguruj swoje ustawienia',
                  body: 'Pamietaj by zaznaczyć także czas powiadomień!',
>>>>>>> ostatnie_szlify
                  decoration: getPageDecoration(),
                  footer: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedTheme,
                        items: ['White', 'Black'].map((theme) {
                          return DropdownMenuItem<String>(
                            value: theme,
                            child: Text(theme),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedTheme = value!;
                          });
                        },
                      ),
<<<<<<< HEAD
=======

>>>>>>> ostatnie_szlify
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
<<<<<<< HEAD
                        onSaved: (value) {
                          username = value;
=======
                        onChanged: (value) {    //nieoptymalne

                          username = value;

>>>>>>> ostatnie_szlify
                        },
                      ),
                      Center(
                          child: ElevatedButton(
<<<<<<< HEAD
                        onPressed: () async {
                          final time = await Navigator.of(context).push(
                            MaterialPageRoute<TimeOfDay?>(
                              builder: (context) => TimePickerScreen(
                                initialTime: selectedNotificationTime,
                              ),
                            ),
                          );

                          if (time != null) {
                            setState(() {
                              selectedNotificationTime = time;
                            });
                          }
                        },
                        child: Text('Select Notification Time'),
                      )),
=======
                            onPressed: () async {
                              final time = await Navigator.of(context).push(
                                MaterialPageRoute<TimeOfDay?>(
                                  builder: (context) => TimePickerScreen(
                                    initialTime: selectedNotificationTime,
                                  ),
                                ),
                              );

                              if (time != null) {
                                setState(() {
                                  selectedNotificationTime = time;
                                });
                              }
                            },
                            child: Text('Select Notification Time',overflow: TextOverflow.ellipsis),
                          )),


>>>>>>> ostatnie_szlify
                    ],
                  ),
                ),
              ],
              onDone: () {
<<<<<<< HEAD
=======

                currentUser.setName(username!);

                currentUser.setPrefHour(selectedNotificationTime!.hour);
                currentUser.setPrefMin(selectedNotificationTime!.minute);

                currentUser.setTheme(selectedTheme);


>>>>>>> ostatnie_szlify
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );

                currentUser.setHasSeenIntroductionTrue();
<<<<<<< HEAD
=======



>>>>>>> ostatnie_szlify
              },
              //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
              scrollPhysics: const ClampingScrollPhysics(),
              showDoneButton: true,
              showNextButton: true,
              showBackButton: true,
<<<<<<< HEAD
              back: const Icon(Icons.arrow_back),
              next: const Icon(Icons.forward),
              done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
=======

              back:
              const Icon(Icons.arrow_back),

              next: const Icon(Icons.forward),
              done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
>>>>>>> ostatnie_szlify
              dotsDecorator: getDotsDecorator()),
        ));
  }

<<<<<<< HEAD
  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      pageColor: Colors.white,
=======

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(

      pageColor: Colors.white,

>>>>>>> ostatnie_szlify
      titlePadding: EdgeInsets.only(top: 50),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}

<<<<<<< HEAD
=======


>>>>>>> ostatnie_szlify
class BulletPointListItem extends StatelessWidget {
  final String text;

  BulletPointListItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center, // Center align the children
        children: [
          Icon(Icons.arrow_forward, size: 12),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> ostatnie_szlify
