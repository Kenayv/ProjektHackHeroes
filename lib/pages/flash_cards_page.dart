// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:project_hack_heroes/theme.dart';
import 'dart:math';
import 'flash_card_set_page.dart';
import 'package:project_hack_heroes/main.dart';

class FlashCardSet {
  String fcSetName;
  List<FlashCard> _flashCards = [];

  FlashCardSet({required this.fcSetName}) {
    loadFlashCards();
  }

  void addFlashCard(String frontText, String backText) {
    var contains = _flashCards.where((card) => card.front == frontText && card.back == backText);
    if (contains.isNotEmpty) return;
    _flashCards.add(FlashCard(front: frontText, back: backText));
    saveFlashCards();
  }

  void removeById(int id) {
    if (_flashCards.length - 1 < id || id < 0) return;
    _flashCards.removeAt(id);
    saveFlashCards();
  }

  void saveFlashCards() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/flashcards.json';
      File file = File(filePath);

      List<Map<String, dynamic>> jsonFlashCards = _flashCards.map((card) => card.toJson()).toList();
      Map<String, dynamic> jsonData = {fcSetName: jsonFlashCards};

      // Write the JSON data to the file (this will overwrite any existing content)
      file.writeAsStringSync(jsonEncode(jsonData));
    } catch (e) {
      print("Error while saving flashcards: $e");
    }
  }

  //Reads FlashCards saved in FlashCards.json file and pushes them into FlashCards[] array
  void loadFlashCards() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/flashcards.json';
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
    if (_flashCards.length <= 0) throw Exception("brak kart w tym zestawie!");
    final randomIndex = Random().nextInt(_flashCards.length);
    return _flashCards[randomIndex];
  }

  List<FlashCard> getFlashCards() {
    return _flashCards;
  }

  String getName() {
    return fcSetName;
  }

  void setName(String newName) {
    fcSetName = newName;
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
  List<FlashCardSet> flashCardSets = [];

  void saveFlashCardSets() {
    for (int i = 0; i < flashCardSets.length; i++) {
      flashCardSets[i].saveFlashCards();
    }
  }

  Future<void> loadFlashCardSets() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/flashcards.json';
      File file = File(filePath);

      if (file.existsSync()) {
        String content = file.readAsStringSync();
        Map<String, dynamic> decodedData = jsonDecode(content);

        flashCardSets.clear();

        decodedData.forEach((setName, setData) {
          if (setData is List) {
            FlashCardSet flashCardSet = FlashCardSet(fcSetName: setName);

            flashCardSet.loadFlashCards();
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
      setState(() {}); // Trigger a rebuild after loading data.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: usertheme.Primarybgcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Twoje zestawy fiszek:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: usertheme.TextColor),
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
        backgroundColor: usertheme.Page2,
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
          backgroundColor: usertheme.Primarybgcolor,
          title: Text('Dodaj fiszkę lub zestaw',style: TextStyle(color: usertheme.TextColor)),
          content: StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              width: 250, // Set the desired width
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    dropdownColor: usertheme.Primarybgcolor,
                    decoration: InputDecoration(labelText: 'Zestaw fiszek', labelStyle: TextStyle(color: usertheme.TextColor)),
                    items: fcSetNames.map((theme) {
                      return DropdownMenuItem<String>(

                        value: theme,
                        child: Text(theme,style: TextStyle(color: usertheme.TextColor),),
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
                      decoration: InputDecoration(labelText: 'Nazwa', labelStyle: TextStyle(color: usertheme.TextColor)),
                    ),
                  ),
                  Visibility(
                    visible: selectedValue != newSetVal,
                    child: Column(
                      children: [
                        TextField(
                          controller: inputFront,
                          decoration: InputDecoration(labelText: 'Przód karty', labelStyle: TextStyle(color: usertheme.TextColor)),
                        ),
                        TextField(
                          controller: inputBack,
                          decoration: InputDecoration(labelText: 'Tył karty', labelStyle: TextStyle(color: usertheme.TextColor)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

  void removeFlashCardSet(FlashCardSet setToRemove) {
    flashCardSets.removeWhere((set) => set == setToRemove);
    saveFlashCardSets();
  }

  Future<void> _editSetDialog(FlashCardSet currentSet) async {
    TextEditingController editSetController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: usertheme.Primarybgcolor,
          title: Text('Usuń lub zmień nazwę',style: TextStyle(color: usertheme.TextColor)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: editSetController,
                  decoration: InputDecoration(labelText: 'Nowa nazwa', labelStyle: TextStyle(color: usertheme.TextColor)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Usuń'),
              onPressed: () {
                removeFlashCardSet(currentSet);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
            TextButton(
              child: Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Zmień nazwę'),
              onPressed: () {
                currentSet.setName(editSetController.text);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFlashCardSetItem(FlashCardSet currentFlashCardSet) {
    final randomColor = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1.0,
    );

    return GestureDetector(
      onTap: () {
        if (currentFlashCardSet.getLength() > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FlashCardSetPage(
                  flashCardSet: currentFlashCardSet,
                );
              },
            ),
          );
        }
      },
      onLongPress: () {
        _editSetDialog(currentFlashCardSet);
      },
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 92,
            decoration: BoxDecoration(
              color: randomColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentFlashCardSet.getName(),
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ilość kart: ${currentFlashCardSet.getLength()}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
