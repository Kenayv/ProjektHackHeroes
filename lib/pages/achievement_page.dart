import 'package:flutter/material.dart';
import 'package:project_hack_heroes/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AchievementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: usertheme.Primarybgcolor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Twoje osiągnięcia",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: usertheme.TextColor),
                ),
              ],
            ),
          ),
          Expanded(
            // Używamy Expanded, aby siatka (grid) wypełniła dostępne miejsce
            child: GridView.count(
              crossAxisCount: 3, // 3x3 grid
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 0.7, // Adjust this value to control the aspect ratio of each grid item
              mainAxisSpacing: 16.0, // Add vertical padding
              crossAxisSpacing: 16.0, // Add horizontal padding
              children: <Widget>[
                AchievementTile('Pierwsze kroki', 'Zdobądź 1-dniowy Streak', 'lib/assets/Wood-Streak.svg'),
                AchievementTile('Bez Dnia Przerwy', 'Zdobądź 3-dniowy Streak', 'lib/assets/Copper-Streak.svg'),
                AchievementTile('To już tydzień!', 'Zdobądź 7-dniowy Streak', 'lib/assets/Silver-Streak.svg'),
                AchievementTile('Sigma Grindset', 'Zdobądź 14-dniowy Streak', 'lib/assets/Gold-Streak.svg'),
                //
                AchievementTile('Eat that frog!', 'ukończ 1 zadanie', 'lib/assets/Wood-Tasks alt.svg'),
                AchievementTile('Szybka piątka', 'ukończ 5 zadań', 'lib/assets/Copper-Tasks.svg'),
                AchievementTile('Hush-Hush', 'ukończ 20 zadań', 'lib/assets/Silver-Task.svg'),
                AchievementTile('Hustler', 'ukończ 50 zadań', 'lib/assets/Gold-Task.svg'),
                //
                AchievementTile('Study', 'Osiągnij rekord 5 Fiszki Rush', 'lib/assets/Wood-Rush.svg'),
                AchievementTile('Studi', 'Osiągnij rekord 15 Fiszki Rush', 'lib/assets/Copper-Rush.svg'),
                AchievementTile('Stoody', 'Osiągnij rekord 25 Fiszki Rush', 'lib/assets/Silver-Rush.svg'),
                AchievementTile('Stoodee', 'Osiągnij rekord 45 Fiszki Rush', 'lib/assets/Gold-Rush.svg'),
                //
                AchievementTile('Le Fishe', 'Odgadnij 1 fiszkę', 'lib/assets/Wood-Fiszki.svg'),
                AchievementTile('10/10', 'Odgadnij 10 fiszek', 'lib/assets/Copper-Fiszki.svg'),
                AchievementTile('Fifty-fifty', 'Odgadnij 50 fiszek', 'lib/assets/Silver-Fiszki.svg'),
                AchievementTile('Unstoppable ', 'Odgadnij 250 fiszek', 'lib/assets/Gold-Fiszki.svg'),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class AchievementTile extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  AchievementTile(this.title, this.description, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAchievementPopup(context);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SvgPicture.asset(
              imagePath,
              width: 80.0, // Adjust the image size as needed
              height: 80.0,
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
            ),
            Center(
              child: Text(
                description,
                style: TextStyle(fontSize: 12.0, color: const Color.fromARGB(255, 100, 100, 79)),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAchievementPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min, // Make the dialog smaller
            children: [
              Center(
                // Center the title within the dialog
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0, // You can adjust the font size as needed
                    fontWeight: FontWeight.bold, // Optionally set the font weight
                  ),
                ),
              ),
              SizedBox(height: 10.0), // Add some vertical spacing
              Image.asset(
                imagePath,
                width: 150.0, // Adjust the image size in the popup
                height: 150.0,
              ),
              SizedBox(height: 10.0), // Add some vertical spacing
              Text(description),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adjust padding as needed
        );
      },
    );
  }
}
