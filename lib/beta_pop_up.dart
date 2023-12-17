import 'package:flutter/material.dart';
import 'main.dart';

class BetaPopUpPage extends StatelessWidget {
  const BetaPopUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 245, 250, 1.0),
      body: Stack(children: [
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).size.height * 0.25,
          child: const Image(
            image: AssetImage('lib/assets/BaseLogoSwan.png'),
            width: 300,
            height: 242,
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
                    text: 'Studee\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black)),
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
                  backgroundColor: const Color.fromRGBO(128, 224, 62, 1),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: const Size(200, 64),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                child: const Text('Dalej', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
              ),
            ))
      ]),
    );
  }
}
