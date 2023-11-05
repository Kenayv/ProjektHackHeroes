import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:project_hack_heroes/main.dart';
import '../beta_pop_up.dart';
import 'package:project_hack_heroes/user.dart';
import 'time_picker_screen.dart';
/*
* plik zajmujacy sie wyswietlaniem introduction screena,
* ale tez obslugiwaniem czy uzytkownik go juz widzial czy nie
*
* wogole tez inne sprawy z tym introduyction screenem nie wiem
*
* */


//smieszne funkcje do smiesznych rzeczy


//intrdduction screen




class IntroductionScreens extends StatefulWidget {
  const IntroductionScreens({Key? key}) : super(key: key);

  @override
  _IntroductionScreensState createState() => _IntroductionScreensState();
}
class _IntroductionScreensState extends State<IntroductionScreens> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedTheme = 'White';
  TimeOfDay? selectedNotificationTime;
  String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height:MediaQuery.of(context).size.height,

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
              title: 'Customize Your Experience',
              body: 'Configure your app settings, theme, date, and username.',
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

                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      username = value;
                    },
                  ),
                  Center(
                      child: ElevatedButton(
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


                ],
              ),
            ),
          ],
          onDone: () {

            /*
            setting the perfsharedvariables
             */



            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );

            currentUser.setHasSeenIntroductionTrue();

          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showBackButton: true,

          back:
          const Icon(Icons.arrow_back),

          next: const Icon(Icons.forward),
          done:
          const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotsDecorator()),
        ));
  }


  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(

      pageColor: Colors.white,

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
}