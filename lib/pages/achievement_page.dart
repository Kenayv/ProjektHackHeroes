import 'package:flutter/material.dart';

class AchievementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
      ),
      body: GridView.count(
        crossAxisCount: 3, // 3x3 grid
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 0.8, // Adjust this value to control the aspect ratio of each grid item
        mainAxisSpacing: 16.0, // Add vertical padding
        crossAxisSpacing: 16.0, // Add horizontal padding
        children: <Widget>[
          AchievementTile('Achievement 1', 'Description 1', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 2', 'Description 2', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 3', 'Description 3', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 4', 'Description 4', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 5', 'Description 5', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 6', 'Description 6', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 7', 'Description 7', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 8', 'Description 8', 'lib/assets/temporaryLogo.png'),
          AchievementTile('Achievement 9', 'Description 9', 'lib/assets/temporaryLogo.png'),
          // Add more AchievementTile widgets as needed
        ],
      ),
    );
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              width: 80.0, // Adjust the image size as needed
              height: 80.0,
            ),
            Text(title, style: TextStyle(fontSize: 16.0)),
            Text(
              description,
              style: TextStyle(fontSize: 12.0, color: Colors.grey),
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
