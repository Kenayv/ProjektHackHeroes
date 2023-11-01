import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:math';

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



class FlashCardSet {
  String SetName = "";
  List<String> a = [];
  List<String> b = [];

  FlashCardSet(this.SetName){}

  void addFlashCard() {
    String textA = stdin.readLineSync()!; 
    a.add(textA);

    String textB = stdin.readLineSync()!;
    b.add(textB);
  }

  void addFlashCardDev(String TextA, String TextB) { //nie wiem które będzie lepsze do implementacji w fluttezrze wiec są 2
    a.add(TextA);
    b.add(TextB);
  }

  void learn(){
    int i = 0;
    do{
      print(a[i]);
      print("N - next; C - Change");
      String input = stdin.readLineSync()!;
      if(input == "C"){
        print(b[i]);
        print("N - next; C - Change");
        String input = stdin.readLineSync()!;
        if(input == "C"){
      }else{i++;}
      }else{i++;}
      
    }while(a.length > i);
  }

  void learnDev(){
    bool WasALast = false;
    int input;

      List<String> AorB(){
        if(WasALast){
          WasALast = false;
          return b;
        }else{
          WasALast = true;
          return a;
        }
      }

      int i = 0;
      do{
        WasALast = false;
        do{
        print(AorB()[i]);
        print("1 - next; 2 - Change"); //do usunięcia dołączająć do apki ofc
        input = int.parse(stdin.readLineSync()!); //cza zmienić 1 jako swipe i 2 jako tap na przykład
        }while(input == 2); 
        i++;
      }while(a.length > i);
  }

  void testAmount(int amount){
    int correct = 0;
    for(int i=1;i<=amount;i++){
      int rand = Random().nextInt(a.length);
      print(a[rand]);
      stdin.readLineSync()!;
      print(b[rand]);
      print("Press C if correct");
      String isCorrect = stdin.readLineSync()!;
      if(isCorrect=="C"){
        correct++;
      }
    }
    print("Correct:");
    print(correct);
    print("Inorrect:");
    print(amount - correct);
  }

  void testShuffled(){
    int correct = 0;
    List<String> c = a;
    List<String> d = b;

      Random random = Random();

  for (int i = c.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);

    String tempA = c[i];
    c[i] = c[j];
    c[j] = tempA;

    String tempB = d[i];
    d[i] = d[j];
    d[j] = tempB;
  }

    for(int i=0;i<c.length;i++){
      print(c[i]);
      stdin.readLineSync()!;
      print(d[i]);
      print("Press C if correct");
      String isCorrect = stdin.readLineSync()!;
      if(isCorrect=="C"){
        correct++;
      }
    }
    print("Correct:");
    print(correct);
    print("Inorrect:");
    print(d.length - correct);
  }

  void testTimed(int Time){ //Time is in miliseconds
    int correct = 0;
    int counter = 0;
    DateTime endTime = DateTime.now().add(Duration(milliseconds: Time));
      while(DateTime.now().isBefore(endTime)){
        int rand = Random().nextInt(a.length);
        print(a[rand]);
        stdin.readLineSync()!;
        print(b[rand]);
        print("Press C if correct");
        String isCorrect = stdin.readLineSync()!;
        if(isCorrect=="C"){
          correct++;
      }
      counter++;
    }
    print("Correct:");
    print(correct);
    print("Inorrect:");
    print(counter - correct);
  }

  void removeById(int Id){
    a.removeAt(Id);
    b.removeAt(Id);
  }
}