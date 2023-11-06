import 'package:flutter/material.dart';
import 'flash_cards_page.dart';

class FlashCardSetPage extends StatefulWidget {
  FlashCardSet flashCardSet;
  FlashCardSetPage({required this.flashCardSet});

  @override
  _FlashCardSetPageState createState() => _FlashCardSetPageState(currentFlashCardSet: flashCardSet);
}

class _FlashCardSetPageState extends State<FlashCardSetPage> {
  FlashCardSet currentFlashCardSet;
  late FlashCard currentCard = currentFlashCardSet.getRandFlashCard();
  bool isFlipped = false;
  bool showRatingButtons = false;
  void flipCard() {
    setState(() {
      if (isFlipped) {
        currentCard = currentFlashCardSet.getRandFlashCard();
      }
      isFlipped = !isFlipped;
      showRatingButtons = isFlipped;
    });
  }

  _FlashCardSetPageState({required this.currentFlashCardSet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap your content in a Scaffold to get the default app background
      appBar: AppBar(
        title: Text(currentFlashCardSet.getName()), // Add an AppBar if needed
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white, // Set the color to white as well
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 300),
                    crossFadeState: isFlipped ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: Text(
                      currentCard.front,
                      style: TextStyle(fontSize: 20),
                    ),
                    secondChild: Text(
                      currentCard.back,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (!isFlipped)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isFlipped = !isFlipped;
                    });
                  },
                  child: Text('Pokaż odpowiedź'),
                ),
              if (isFlipped)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flipCard();
                        });
                      },
                      child: Text('Dobrze'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flipCard();
                        });
                      },
                      child: Text('Źle'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
