import 'package:flutter/material.dart';

class FlashCardsPage extends StatefulWidget {
  @override
  _FlashCardsPageState createState() => _FlashCardsPageState();
}

class _FlashCardsPageState extends State<FlashCardsPage> {
  bool isFlipped = false;
  bool showRatingButtons = false;

  void flipCard() {
    setState(() {
      isFlipped = !isFlipped;
      showRatingButtons = isFlipped;
    });
  }

  void unflipCard() {
    setState(() {
      isFlipped = false;
      showRatingButtons = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  crossFadeState: isFlipped ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: Text(
                    'Front of the Card',
                    style: TextStyle(fontSize: 20),
                  ),
                  secondChild: Text(
                    'Back of the Card',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (!showRatingButtons)
              ElevatedButton(
                onPressed: flipCard,
                child: Text('Flip Card'),
              ),
            if (showRatingButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      unflipCard();
                    },
                    child: Text('Dobrze'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      unflipCard();
                    },
                    child: Text('Źle'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
