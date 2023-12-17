import 'package:flutter/material.dart';
import 'package:project_hack_heroes/theme.dart';
import '../user.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: usertheme.primarybgcolor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('lib/assets/BurnOutSorry.png'),
            ),
            const SizedBox(height: 10),
            Text(
              currentUser.getName(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: usertheme.textColor,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPopupButton(context, 'About Us'),
                  _buildPopupButton(context, 'Settings'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Statystyki:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: usertheme.textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildStatItem('Obecny Streak', currentUser.getDayStreak().toString()),
                  _buildStatItem('Ukończone zadania', currentUser.getFinishedTasks().toString()),
                  _buildStatItem('Nieukończone zadania', currentUser.getFailedTasks().toString()),
                  _buildStatItem('Wykonanych zadań', '${currentUser.getTaskCompletion().toStringAsFixed(2)}%'),
                  _buildStatItem('Rekord Fiszki Rush', currentUser.getHighScoreFCRush().toString()),
                  _buildStatItem('Ukończone Fiszki', currentUser.getCompletedFC().toString()),
                  _buildStatItem('Najdłuższy Streak', currentUser.getLongestStreak().toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () {
        if (title == "About Us") {
          _showAboutUsDialog(context);
        } else if (title == "Settings") {
          _showSettingsDialog(context);
        }
      },
      child: Text(title),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: usertheme.textColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: usertheme.textColor,
          ),
        ),
      ],
    );
  }
}

void _showAboutUsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'About Us',
          style: TextStyle(color: usertheme.textColor),
        ),
        backgroundColor: usertheme.primarybgcolor,
        content: SizedBox(
          height: 380, // Adjust the height as needed
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Add your about us content here

                Image.asset('lib/assets/zdjecie2.png', width: 150, height: 150),

                Container(
                  margin: const EdgeInsets.only(top: 3.0), // Adjust the margin as needed
                  child: Text(
                    'Aplikacja Studee',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: usertheme.textColor),
                    // Set your desired alignment
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 12.0), // Adjust the margin as needed
                  child: Text(
                    'Jestesmy uczniami Szkoly ZSTiO Meritum, klasy 4Bt',
                    textAlign: TextAlign.center, // Set your desired alignment
                    style: TextStyle(color: usertheme.textColor),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 4.0, bottom: 4.0), // Adjust the margin as needed

                  child: Text(
                    'Autorzy:',
                    textAlign: TextAlign.center, // Set your desired alignment
                    style: TextStyle(color: usertheme.textColor),
                  ),
                ),
                Text(
                  '1. Janek Grosicki - ogólna struktura aplikacji',
                  style: TextStyle(color: usertheme.textColor),
                ),
                Text(
                  '2. Wiktor Gradzik -Lista ToDo  ',
                  style: TextStyle(color: usertheme.textColor),
                ),
                Text(
                  '3. Konrad Kaspirowicz- Fiszki, ikonki',
                  style: TextStyle(color: usertheme.textColor),
                ),
                Text(
                  '4. Marcin Skrzypek - Introduction Screen, mniejsze screeny',
                  style: TextStyle(color: usertheme.textColor),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      String username = currentUser.getName(); // Initialize with your default username.
      String selectedTheme = currentUser.getTheme(); // Initialize with your default theme.
      TimeOfDay selectedNotificationTime = TimeOfDay(
          hour: currentUser.getPrefHour(), minute: currentUser.getPrefMin()); // Initialize with your default time.

      return AlertDialog(
        title: Text(
          'Customize Your Experience',
          style: TextStyle(color: usertheme.textColor),
        ),
        backgroundColor: usertheme.primarybgcolor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButtonFormField<String>(
              dropdownColor: usertheme.primarybgcolor,
              value: selectedTheme,
              items: ['White', 'Black'].map((theme) {
                return DropdownMenuItem<String>(
                  value: theme,
                  child: Text(
                    theme,
                    style: TextStyle(color: usertheme.textColor),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                selectedTheme = value!;
              },
            ),
            TextFormField(
              initialValue: username,
              style: TextStyle(color: usertheme.textColor),
              decoration: InputDecoration(labelText: 'Username', labelStyle: TextStyle(color: usertheme.textColor)),
              onChanged: (value) {
                username = value;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: selectedNotificationTime,
                );

                if (time != null) {
                  selectedNotificationTime = time;
                }
              },
              child: const Text('Notification Time'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              currentUser.setName(username);

              currentUser.setPrefHour(selectedNotificationTime.hour);
              currentUser.setPrefMin(selectedNotificationTime.minute);

              currentUser.setTheme(selectedTheme);
              
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void main() {
  runApp(const MaterialApp(
    home: AccountPage(),
  ));
}
