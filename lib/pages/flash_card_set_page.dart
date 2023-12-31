import 'package:flutter/material.dart';
import 'package:project_hack_heroes/theme.dart';
import 'package:project_hack_heroes/user.dart';
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

  void showSettingsDialog(BuildContext context, FlashCardSet currentFlashCardSet, FlashCard currentFlashCard) {
    TextEditingController frontController = TextEditingController(text: currentFlashCard.front);
    TextEditingController backController = TextEditingController(text: currentFlashCard.back);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edytuj fiszkę'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: frontController,
                decoration: InputDecoration(labelText: currentFlashCard.front),
              ),
              TextField(
                controller: backController,
                decoration: InputDecoration(labelText: currentFlashCard.back),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                currentFlashCardSet.getFlashCards().removeWhere((element) => element == currentFlashCard);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text('Usuń'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Anuluj'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentFlashCard.front = frontController.text;
                  currentFlashCard.back = backController.text;
                });
              },
              child: Text('Zapisz'),
            ),
          ],
        );
      },
    );
  }

  _FlashCardSetPageState({required this.currentFlashCardSet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: usertheme.Primarybgcolor,
      // Wrap your content in a Scaffold to get the default app background
      appBar: AppBar(
        title: Text(currentFlashCardSet.getName()),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String choice) {
              if (choice == 'settings') {
                showSettingsDialog(context, currentFlashCardSet, currentCard);
              }
            },
            itemBuilder: (BuildContext context) {
              return ['settings'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(Icons.settings),
                      SizedBox(width: 8),
                      Text('Settings'),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        color: usertheme.Primarybgcolor, // Set the background color to white
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: usertheme.Primarybgcolor, // Set the color to white as well
                  border: Border.all(
                    color: usertheme.TextColor,
                    width: 4.0, // Adjust this value to make the border thicker
                  ),
                ),
                child: Center(
                  child: AnimatedCrossFade(
                    duration: Duration(milliseconds: 300),
                    crossFadeState: isFlipped ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: Text(
                      currentCard.front,
                      style: TextStyle(fontSize: 20,color: usertheme.TextColor),
                    ),
                    secondChild: Text(
                      currentCard.back,
                      style: TextStyle(fontSize: 20,color: usertheme.TextColor),
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
                  child: Container(
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    child: Text('Pokaż odpowiedź'),
                  ),
                ),
              if (isFlipped)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        currentUser.incrCompletedFlashCard();
                        setState(() {
                          flipCard();
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 80,
                        alignment: Alignment.center,
                        child: Text('Dobrze'),
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          flipCard();
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 80,
                        alignment: Alignment.center,
                        child: Text('Źle'),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
