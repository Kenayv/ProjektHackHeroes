// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class FlashCardSet {
  final String fcSetName;
  List<FlashCard> _flashCards = [];

  FlashCardSet({required this.fcSetName}) {
    _loadFlashCards();
  }

  void addFlashCard(String frontText, String backText) {
    var contains = _flashCards.where((card) => card.front == frontText && card.back == backText);
    if (contains.isNotEmpty) return;
    _flashCards.add(FlashCard(front: frontText, back: backText));
    _saveFlashCards();
  }

  void removeById(int id) {
    if (_flashCards.length - 1 < id || id < 0) return;
    _flashCards.removeAt(id);
    _saveFlashCards();
  }

  void _saveFlashCards() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = 'FlashCards.json'; //FIXME
      File file = File(filePath);

      Map<String, dynamic> jsonData = {};

      // Check if the file exists and read its content
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        jsonData = jsonDecode(content);
      }

      // Convert the flashcards to JSON format
      List<Map<String, dynamic>> jsonFlashCards = _flashCards.map((card) => card.toJson()).toList();

      // Store the flashcards in the "setOne" object in the JSON data
      jsonData[fcSetName] = jsonFlashCards;

      // Write the updated JSON data back to the file
      file.writeAsStringSync(jsonEncode(jsonData));
    } catch (e) {
      print("Error while saving flashcards: $e");
    }
  }

  //Reads FlashCards saved in FlashCards.json file and pushes them into FlashCards[] array
  void _loadFlashCards() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = 'FlashCards.json'; //FIXME
      File file = File(filePath);
      if (file.existsSync()) {
        String content = file.readAsStringSync();
        Map<String, dynamic> decodedData = jsonDecode(content);

        // Ensure "fcSetName" exists in the JSON data
        if (decodedData.containsKey(fcSetName)) {
          List<dynamic> fcSetNameFlashCards = decodedData[fcSetName];

          // Map the flashcards from "fcSetName" to your FlashCard objects
          List<FlashCard> loadedFlashCards = fcSetNameFlashCards.map((card) => FlashCard.fromJson(card)).toList();
          _flashCards = loadedFlashCards;
        } else {
          // Handle the case where "fcSetName" does not exist in the JSON file
          print("The '$fcSetName' object does not exist in the JSON file.");
        }
      }
    } catch (e) {
      print("Error while loading flashcards: $e");
    }
  }

  FlashCard getRandFlashCard() {
    final randomIndex = Random().nextInt(_flashCards.length);
    return _flashCards[randomIndex];
  }

  String getName() {
    return fcSetName;
  }

  int getLength() {
    return _flashCards.length;
  }
}

class FlashCard {
  String front;
  String back;

  FlashCard({
    required this.front,
    required this.back,
  });

  Map<String, dynamic> toJson() {
    return {
      'front': front,
      'back': back,
    };
  }

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      front: json['front'] ?? "błąd ładowania karty",
      back: json['back'] ?? "błąd ładowania karty",
    );
  }
}

class FlashCardsPage extends StatefulWidget {
  @override
  _FlashCardsPageState createState() => _FlashCardsPageState();
}

class _FlashCardsPageState extends State<FlashCardsPage> {
  bool isFlipped = false;
  bool showRatingButtons = false;
  List<FlashCardSet> flashCardSets = [];

  void flipCard() {
    setState(() {
      isFlipped = !isFlipped;
      showRatingButtons = isFlipped;
    });
  }

  void saveFlashCardSets() {
    for (int i = 0; i < flashCardSets.length; i++) {
      flashCardSets[i]._saveFlashCards();
    }
  }

  Future<void> loadFlashCardSets() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = 'FlashCards.json'; //FIXME:
      File file = File(filePath);

      if (file.existsSync()) {
        String content = file.readAsStringSync();
        Map<String, dynamic> decodedData = jsonDecode(content);

        flashCardSets.clear();

        decodedData.forEach((setName, setData) {
          if (setData is List) {
            FlashCardSet flashCardSet = FlashCardSet(fcSetName: setName);

            flashCardSet._loadFlashCards();
            flashCardSets.add(flashCardSet);
          }
        });
      }
    } catch (e) {
      print("Error while loading FlashCardSets: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    loadFlashCardSets().then((_) {
      // Debug print statements
      print('Number of flashCardSets: ${flashCardSets.length}');
      setState(() {}); // Trigger a rebuild after loading data.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Twoje zestawy fiszek:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: flashCardSets.length,
              itemBuilder: (context, index) {
                FlashCardSet flashCardSet = flashCardSets[index];
                return _buildFlashCardSetItem(flashCardSet);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addFlashCardDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<dynamic> _addFlashCardDialog() {
    TextEditingController inputName = TextEditingController();
    TextEditingController inputFront = TextEditingController();
    TextEditingController inputBack = TextEditingController();
    String? selectedValue = "";
    List<String> fcSetNames = [];
    for (int i = 0; i < flashCardSets.length; i++) {
      fcSetNames.add(flashCardSets[i].getName());
    }
    const String newSetVal = "Nowy...";
    fcSetNames.add(newSetVal);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dodaj Fiszkę'),
          content: StatefulBuilder(builder: (context, setState) {
            return Column(
              children: <Widget>[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Zestaw fiszek'),
                  items: fcSetNames.map((theme) {
                    return DropdownMenuItem<String>(
                      value: theme,
                      child: Text(theme),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                Visibility(
                  visible: selectedValue == newSetVal,
                  child: TextField(
                    controller: inputName,
                    decoration: InputDecoration(labelText: 'Nazwa'),
                  ),
                ),
                Visibility(
                  visible: selectedValue != newSetVal,
                  child: Column(
                    children: [
                      TextField(
                        controller: inputFront,
                        decoration: InputDecoration(labelText: 'Przód karty'),
                      ),
                      TextField(
                        controller: inputBack,
                        decoration: InputDecoration(labelText: 'Tył karty'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          actions: <Widget>[
            TextButton(
              child: Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Dodaj'),
              onPressed: () {
                if (selectedValue == newSetVal) {
                  flashCardSets.add(FlashCardSet(fcSetName: inputName.text));
                } else {
                  final int index = flashCardSets.indexWhere((flashCardSet) => flashCardSet.fcSetName == selectedValue);
                  if (index == -1) Navigator.of(context).pop();
                  flashCardSets[index].addFlashCard(inputFront.text, inputBack.text);
                }
                saveFlashCardSets();
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlashCardSetItem(FlashCardSet flashCardSet) {
    final randomColor = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1.0,
    );

    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: randomColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  flashCardSet.getName(),
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ilość kart: ${flashCardSet.getLength()}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// return Scaffold(
    //   body: FutureBuilder<void>(
    //     future: loadFlashCardSets(), // Call the function here
    //     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // Now you can safely access flashCardSets
    //         FlashCard? testowa = flashCardSets.isNotEmpty ? flashCardSets[0].getRandFlashCard() : null;

    //         return Center(
    // child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Container(
    //       width: 200,
    //       height: 400,
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         border: Border.all(color: Colors.black),
    //       ),
    //       child: Center(
    //         child: AnimatedCrossFade(
    //           duration: Duration(milliseconds: 300),
    //           crossFadeState: isFlipped ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    //           firstChild: Text(
    //             testowa?.front ?? 'Front text not available',
    //             style: TextStyle(fontSize: 20),
    //           ),
    //           secondChild: Text(
    //             testowa?.back ?? 'Back text not available',
    //             style: TextStyle(fontSize: 20),
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizedBox(height: 20),
    //     if (!showRatingButtons)
    //       ElevatedButton(
    //         onPressed: flipCard,
    //         child: Text('Flip Card'),
    //       ),
    //     if (showRatingButtons)
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           ElevatedButton(
    //             onPressed: () {
    //               flipCard();
    //             },
    //             child: Text('Dobrze'),
    //           ),
    //           SizedBox(width: 20),
    //           ElevatedButton(
    //             onPressed: () {
    //               flipCard();
    //             },
    //             child: Text('Źle'),
    //           ),
    //         ],
    //       ),
    //   ],
    // ),
    // );
    //   } else {
    //     // Handle loading state, for example, display a loading indicator
    //     return Center(child: CircularProgressIndicator());
    //   }
    // },
    //   ),
    // );