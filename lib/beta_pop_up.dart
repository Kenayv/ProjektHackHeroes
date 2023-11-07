import 'package:flutter/material.dart';
import 'main.dart';

class BetaPopUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(48, 54, 48, 1),
      body: Stack(children: [
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * 0.25,
          child: Image(
            image: AssetImage('lib/assets/temporaryLogo.png'),
            width: 150,
            height: 121,
          ),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * 0.50,
          child: const Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Studee\n',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Colors.white,
                    )),
                TextSpan(
                    text: 'UWAGA!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    )),
                TextSpan(
                    text:
                        ' Studee jest w stanie beta.\nOznacza to, że błędy mogą nadal występować\nProsimy, miej to na uwadze podczas nauki.\n',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      color: Color.fromRGBO(128, 128, 128, 1),
                    )),
                TextSpan(
                    text: 'Naciśnij przycisk poniżej przejść dalej.',
                    style: TextStyle(
                      fontSize: 18,
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
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(128, 224, 62, 1),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(200, 64),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                child: Text('Dalej', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              ),
            ))
      ]),
    );
  }
}
