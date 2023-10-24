// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

//
//  -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -
//

void main() => runApp(const MyApp());

//
//  -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -
//

//WARNING: stąd da się wrócić na poprzedni ekran używając <- (strzałki w lewo na telefonie)
class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("main menu")),
    );
  }
}

//
//  -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -
//

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//
//  -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -
//

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//
//  -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -    -
//

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 54, 48, 1),
      body: Stack(children: [
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.width * 0.52,
          child: Image(
            image: AssetImage('lib/assets/temporaryLogo.png'),
            width: 150,
            height: 121,
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.width * 0.85,
          child: const Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Nazwa Projektu\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white,
                    )),
                TextSpan(
                    text: 'Lorem ipsum dolor sit amet\nNaciśnij ',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    )),
                TextSpan(
                    text: 'dalej',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    )),
                TextSpan(
                    text: ' aby przejść dalej ',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    )),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(128, 224, 62, 1),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(140, 40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FirstRoute()),
                  );
                },
                child: Text('Dalej', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              ),
            ))
      ]),
    );
  }
}
